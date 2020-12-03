import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/main.dart';
import 'package:bbmsg_mobile/main_page_mockup.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/utils/custom_dialoug.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:get/get.dart' as myget;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:string_validator/string_validator.dart';

String baseUrl = 'http://ec2-3-23-216-129.us-east-2.compute.amazonaws.com:7425';
var dio = Dio();
AppGet appGet = myget.Get.put(AppGet());
// DioCacheManager profileCach = DioCacheManager(CacheConfig());
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

    myget.Get.off(MainPageMock());
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

    myget.Get.off(MainPageMock());
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
  // dio.interceptors.add(
  //     DioCacheManager(CacheConfig(baseUrl: baseUrl + '/auth')).interceptor);
  try {
    var response = await dio.post(baseUrl + '/auth',
        data: {
          "strategy": strategy,
          "accessToken": token,
        },
        options: Options(headers: {'Content-Type': 'application/json'}));
    Map<String, dynamic> resultMap = response.data;
    appGet.setToken(resultMap['accessToken']);
    appGet.setUserMap(resultMap);
    appGet.pr.hide();

    return resultMap;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
    return null;
  }
}

///////////////////////////////////////////////////////////////////////////////
signOut() {
  SPHelper.spHelper.clearSp();
  FirebaseAuth.instance.signOut();
  myget.Get.off(MainPage());
}

///////////////////////////////////////////////////////////////////////////////
updateUser(String userId, Map map) async {
  try {
    print(FormData.fromMap({...map}));
    // print(map);
    // profileCach.delete('token${appGet.token}', subKey: 'userInfo');

    appGet.pr.show();
    var response = await dio.put(
      baseUrl + '/users/$userId',
      data: FormData.fromMap({...map}),
      options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}),
    );
    Map<String, dynamic> resultMap = response.data;

    appGet.setUserMap({'user': resultMap});

    appGet.pr.hide();
  } on DioError catch (e) {
    logger.e(e.response);
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
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////
getFollowing(bool followers) async {
  try {
    var response = await dio.get(baseUrl + '/follows?following=$followers',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setFollowing(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

//////////////////////////////////////////////////////////////////////////////////////
getPosts({String userId}) async {
  String prefix = userId != null ? '/posts?user_id=$userId' : '/posts';
  String url = baseUrl + prefix;

  try {
    var response = await dio.get(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setPosts(mmnlist1);
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
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser =
      await GoogleSignIn(scopes: []).signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  String tken = await userCredential.user.getIdToken();
  logger.e(tken);
  // Once signed in, return the UserCredential
  return userCredential;
}

Future<UserCredential> signInWithFacebook() async {
  final AccessToken result = await FacebookAuth.instance.login();

  final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.token);

  return await FirebaseAuth.instance
      .signInWithCredential(facebookAuthCredential);
}

Future<UserCredential> signInWithTwitter() async {
  // Create a TwitterLogin instance
  final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'wih4kklIITuTvGAeYdNcDg0oY',
    consumerSecret: 'LLloRbpQRFd5vOKRIPoeJIfPvSvsgqrw958FaxZXogpLq1xq9n',
  );

  // Trigger the sign-in flow
  final TwitterLoginResult loginResult = await twitterLogin.authorize();

  // Get the Logged In session
  final TwitterSession twitterSession = loginResult.session;

  // Create a credential from the access token
  final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
      accessToken: twitterSession.token, secret: twitterSession.secret);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance
      .signInWithCredential(twitterAuthCredential);
}

User checkUser() {
  User user = FirebaseAuth.instance.currentUser;
  return user;
}
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
//  var response = await dio.post(url + '/user/update_password',
//         data: {"old_password": oldPassword, "new_password": newPassword},
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${appGet.token}'
//         }));
