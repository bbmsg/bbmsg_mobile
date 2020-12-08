import 'dart:io';

import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/main.dart';
import 'package:flutter/services.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/insta_home.dart';
import 'package:bbmsg_mobile/utils/custom_dialoug.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:get/get.dart' as myget;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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

    myget.Get.off(InstaHome(0));
  } on DioError catch (e) {
    appGet.pr.hide();
    CustomDialougs.utils
        .showDialoug(titleKey: 'error', messageKey: e.response.data['message']);
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
    getFollowers(true);
    getFollowing(true);
    getPosts();
    getMyPosts(myId: '${resultMap['user']['id']}');
    appGet.pr.hide();

    myget.Get.off(InstaHome(0));
  } on DioError catch (e) {
    appGet.pr.hide();

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
    logger.e(resultMap);
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

////////////////////////////////////////////////////////////////////////////////////////
getMyPosts({String myId}) async {
  String prefix = '/posts?user_id=$myId';
  String url = baseUrl + prefix;

  try {
    var response = await dio.get(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${appGet.token}'
        }));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setMyPosts(mmnlist1);
    logger.e('my posts are $mmnlist1');
    return mmnlist1;
  } on DioError catch (e) {
    logger.e(e.response);
  }
}

//////////////////////////////////////////////////////////////////////////////////////
Future<Map<String, dynamic>> getPosts({String userId}) async {
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
    logger.e(mmnlist1);
    return mmnlist1;
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
  try {
    final GoogleSignInAccount googleUser =
        await GoogleSignIn(scopes: []).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    String token = await userCredential.user.getIdToken();
    socialMediaAuth(strategy: 'google', token: googleAuth.accessToken);

    // Once signed in, return the UserCredential
    return userCredential;
  } catch (e) {
    CustomDialougs.utils.showDialoug(titleKey: 'Error', messageKey: e.message);
  }
}

Future<UserCredential> signInWithFacebook() async {
  try {
    final AccessToken result = await FacebookAuth.instance.login();

    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    String token = await userCredential.user.getIdToken();
    socialMediaAuth(strategy: 'facebook', token: result.token);
    return userCredential;
  } catch (e) {
    CustomDialougs.utils.showDialoug(titleKey: 'Error', messageKey: e.message);
  }
}

Future<UserCredential> signInWithTwitter() async {
  // Create a TwitterLogin instance
  try {
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

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    String token = await userCredential.user.getIdToken();
    socialMediaAuth(strategy: 'twitter', token: token);
    return userCredential;
  } catch (e) {
    CustomDialougs.utils.showDialoug(titleKey: 'Error', messageKey: e.message);
  }
}

User checkUser() {
  User user = FirebaseAuth.instance.currentUser;
  return user;
}

/////////////////////////////////////////////////////////////////////////////////////
socialMediaAuth({String token, String strategy}) async {
  appGet.pr.show();
  try {
    Map map = {"strategy": strategy, "accessToken": token};

    var response = await dio.post(baseUrl + '/auth',
        data: map,
        options: Options(headers: {'Content-Type': 'application/json'}));
    Map<String, dynamic> resultMap = response.data;
    appGet.setToken(resultMap['accessToken']);
    appGet.setUserMap(resultMap);
    appGet.pr.hide();

    myget.Get.off(InstaHome(0));
  } on DioError catch (e) {
    appGet.pr.hide();
    logger.e(e.response.data['message']);
    CustomDialougs.utils
        .showDialoug(titleKey: 'Error', messageKey: e.response.data['message']);
  }
}
/////////////////////////////////////////////////////////////////////////////////////
//  var response = await dio.post(url + '/user/update_password',
//         data: {"old_password": oldPassword, "new_password": newPassword},
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${appGet.token}'
//         }));
/////////////////////////////////////////////////////////////////////////////////////////

Future<MultipartFile> convertAssetToMultipart(Asset image) async {
  ByteData byteData = await image.getByteData();
  List<int> imageData = byteData.buffer.asUint8List();
  MultipartFile multipartFile = await MultipartFile.fromBytes(imageData,
      filename: image.name.substring(0, image.name.lastIndexOf('.')) + '.jpeg',
      contentType: MediaType('image', 'jpeg'));
  return multipartFile;
}

Future<List<MultipartFile>> ListAssetToListMultipart(List<Asset> images) async {
  List<MultipartFile> multiParts = [];
  for (Asset asset in images) {
    MultipartFile multipartFile = await convertAssetToMultipart(asset);
    multiParts.add(multipartFile);
  }
  return multiParts;
}

Future<bool> createPost(String content, List<Asset> images) async {
  appGet.pr.show();
  List<MultipartFile> multiParts = await ListAssetToListMultipart(images);
  logger.e(multiParts.first.filename);

  try {
    var response = await dio.post(baseUrl + '/posts',
        data: FormData.fromMap({'content': content, 'media': multiParts}),
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
    getMyPosts(myId: appGet.userMap['user']['id'].toString());
    appGet.pr.hide();
    logger.e(mmnlist1);
    return true;
  } on DioError catch (e) {
    appGet.pr.hide();
    logger.e(e.response.data['message']);
    return false;
  }
}

/////////////////////////////////////////////////////////////////////////////////////

editPost(int id, String content, File img, int tags) async {
  String fileName = img.path.split('/').last;
  try {
    var response = await dio.put(baseUrl + '/posts/$id',
        data: {
          'content': content,
          // 'media': await MultipartFile.fromFile(img.path, filename: fileName),
          'tags': tags,
        },
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

deletepost(int id) async {
  try {
    var response = await dio.delete(baseUrl + '/posts/$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

getcomments() async {
  try {
    var response = await dio.get(baseUrl + '/comments',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setcommentpost(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

getAcomment(int id) async {
  try {
    var response = await dio.get(baseUrl + '/comments/$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
    appGet.setcommentpostbyid(mmnlist1);
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

createComment(int postId, String content, File img, File img2) async {
  String fileName = img == null ? null : img.path.split('/').last;
  String fileName2 = img2 == null ? null : img2.path.split('/').last;
  try {
    var response = await dio.post(baseUrl + '/comments',
        data: {
          'post_id': postId,
          'content': content,

          'media': img == null
              ? null
              : await MultipartFile.fromFile(img.path, filename: fileName),

          'media': img2 == null
              ? null
              : await MultipartFile.fromFile(img2.path, filename: fileName2),

          // 'tags': tags
        },
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

editComment(int id, String content) async {
  try {
    var response = await dio.put(baseUrl + '/comments/$id',
        data: {
          'content': content,
        },
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

deleteComment(int id) async {
  try {
    var response = await dio.delete(baseUrl + '/comments/$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

getReplies() async {
  try {
    var response = await dio.get(baseUrl + '/replies',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

getAreplay(int id) async {
  try {
    var response = await dio.get(baseUrl + '/replies/$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

createreplay(int commentId, int tags, File img) async {
  String fileName = img.path.split('/').last;
  try {
    var response = await dio.post(baseUrl + '/replies',
        data: {
          'comment_id': commentId,
          // 'media': await MultipartFile.fromFile(img.path, filename: fileName),
          'tags': tags
        },
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

editReplay(int id, String content) async {
  try {
    var response = await dio.put(baseUrl + '/replies/$id',
        data: {
          'content': content,
        },
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

deleteReplay(int id) async {
  try {
    var response = await dio.delete(baseUrl + '/replies/$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

Future getLikes(int id) async {
  try {
    var response = await dio.get(baseUrl + '/likes?post_id=$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;

    return mmnlist1;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

Future like(int postId) async {
  print(postId);
  try {
    var response = await dio.post(baseUrl + '/likes',
        data: {
          'post_id': postId,
        },
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;

    return mmnlist1;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

Future removelike(int id) async {
  try {
    var response = await dio.delete(baseUrl + '/likes/$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}

/////////////////////////////////////////////////////////////////////////////////////

Future getActivity(int id) async {
  String limit;
  try {
    var response = await dio.get(baseUrl + '/activity?$limit=$id',
        options: Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
    Map<String, dynamic> mmnlist1 = response.data;

    return mmnlist1;
  } on DioError catch (e) {
    logger.e(e.response.data['message']);
  }
}
