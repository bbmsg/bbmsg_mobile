import 'package:bbmsg_mobile/Splash.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/main.dart';
import 'package:bbmsg_mobile/main_page_mockup.dart';
import 'package:bbmsg_mobile/services%20copy/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/utils/custom_dialoug.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:string_validator/string_validator.dart';

String baseUrl = 'http://ec2-3-23-216-129.us-east-2.compute.amazonaws.com:7425';
var dio = Dio();
AppGet appGet = Get.put(AppGet());
DioCacheManager profileCach = DioCacheManager(CacheConfig());
Logger logger = Logger();

registerNewUser({String userName, String credintial, String password}) async {
  appGet.pr.show();
  Map map = isEmail(credintial)
      ? {"name": userName, "email": credintial, "password": password}
      : {"name": userName, "phone_number": credintial, "password": password};
  try {
    var response = await dio.post(baseUrl + '/users',
        data: map,
        options: Options(headers: {'Content-Type': 'application/json'}));
    Map<String, dynamic> resultMap = response.data;
    resultMap['accessToken'] =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2MDUyNzgyNTQsImV4cCI6MTYzNjgxNDI1NCwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo3NDI1IiwiaXNzIjoiZmVhdGhlcnMiLCJzdWIiOiIyIiwianRpIjoiNjk0MDFiOWUtMDBmZC00MDU1LTg5OTQtOWNhNTBiMWU4YTQyIn0.RroVEVR8QWrUN9gb1YC331FGvQUZQU8qW3QF1AgfZwY";
    appGet.setToken(resultMap['accessToken']);
    appGet.setUserMap(resultMap);
    appGet.pr.hide();
    logger.d(resultMap);
    Get.off(MainPageMock());
  } on DioError catch (e) {
    appGet.pr.hide();
    logger.e(e.response.data['message']);
  }
}

///////////////////////////////////////////////////////////////////////////////////
getUserToken(
    {String credintial, String strategy = 'local', String password}) async {
  appGet.pr.show();
  try {
    Map map = isEmail(credintial)
        ? {"strategy": strategy, "email": credintial, "password": password}
        : {
            "strategy": strategy,
            "phone_number": credintial,
            "password": password
          };

    var response = await dio.post(baseUrl + '/auth',
        data: map,
        options: Options(headers: {'Content-Type': 'application/json'}));
    Map<String, dynamic> resultMap = response.data;
    appGet.setToken(resultMap['accessToken']);
    appGet.setUserMap(resultMap);
    appGet.pr.hide();
    logger.d(resultMap);
    Get.off(MainPageMock());
  } on DioError catch (e) {
    appGet.pr.hide();
    logger.e(e.response.data['message']);
    CustomDialougs.utils
        .showDialoug(titleKey: 'Error', messageKey: e.response.data['message']);
  }
}

///////////////////////////////////////////////////////////////////////////////////
Future<Map<String, dynamic>> retrieveUser(
    {String strategy = 'jwt', String token}) async {
  dio.interceptors.add(
      DioCacheManager(CacheConfig(baseUrl: baseUrl + '/auth')).interceptor);
  try {
    var response = await dio.post(
      baseUrl + '/auth',
      data: {
        "strategy": strategy,
        "accessToken": token,
      },
      options: buildCacheOptions(Duration(days: 7),
          primaryKey: 'token$token',
          subKey: 'userInfo',
          options: Options(headers: {'Content-Type': 'application/json'})),
    );
    Map<String, dynamic> resultMap = response.data;
    appGet.setToken(resultMap['accessToken']);
    appGet.setUserMap(resultMap);
    appGet.pr.hide();
    logger.d(resultMap);
    return resultMap;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
    return null;
  }
}

///////////////////////////////////////////////////////////////////////////////
signOut() {
  SPHelper.spHelper.clearSp();
  Get.off(MainPage());
}

///////////////////////////////////////////////////////////////////////////////
updateUser(String userId, Map map) async {
  try {
    profileCach.delete('token${appGet.token}', subKey: 'userInfo');
    var response = await dio.put(
      baseUrl + '/users/$userId',
      data: map,
      options: buildCacheOptions(Duration(days: 7),
          primaryKey: 'token${appGet.token}',
          subKey: 'userInfo',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${appGet.token}'
          })),
    );
    Map<String, dynamic> resultMap = response.data;
    appGet.setToken(resultMap['accessToken']);
    appGet.setUserMap(resultMap);
    appGet.pr.hide();
    logger.d(resultMap);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
getUsers({String limit = '10', String skip = '0'}) async {
  try {
    var response = await dio.get(baseUrl + '/users?\$limit=$limit&\$skip=$skip',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////
getUser(String userId) async {
  try {
    var response = await dio.get(baseUrl + '/users/$userId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

////////////////////////////////////////////////////////////////////////////////////
deleteUser(String userId) async {
  try {
    var response = await dio.delete(baseUrl + '/users/$userId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    SPHelper.spHelper.clearSp();
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
getFollowers(bool followers) async {
  try {
    var response = await dio.get(baseUrl + '/follows?followers=$followers',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setFollowers(mmnlist1);
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////
GetFollowing(bool followers) async {
  try {
    var response = await dio.get(baseUrl + '/follows?following=$followers',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setFollowing(mmnlist1);
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

//////////////////////////////////////////////////////////////////////////////////////
getPosts({String userId}) async {
  String prefix = userId != null ? '/posts?user_id=$userId' : '/posts';
  String url = baseUrl + prefix;
  logger.e(url);

  try {
    var response = await dio.get(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setPosts(mmnlist1);
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response);
  }
}

/////////////////////////////////////////////////////////////////////////////////////
followUser(String userId) async {
  try {
    var response = await dio.post(baseUrl + '/follows',
        data: {'followee_id': userId},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////
unFollowUser(String userId) async {
  try {
    var response = await dio.delete(baseUrl + '/follows/$userId',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    logger.d(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}
/////////////////////////////////////////////////////////////////////////////////////
//  var response = await dio.post(url + '/user/update_password',
//         data: {"old_password": oldPassword, "new_password": newPassword},
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${appGet.token}'
//         }));
