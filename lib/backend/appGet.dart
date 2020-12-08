import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/utils/ProgressDialogUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppGet extends GetxController {
  double screenWidth;
  double screenHeight;
  var testArray = [1, 2, 3, 4, 5, 6, 7].obs;
  var isLoading = false.obs;
  var userMap = Map().obs;
  var followers = {}.obs;
  var following = {}.obs;
  var posts = {}.obs;
  Map testMap = {};
  var appBarTitleStyle = TextStyle().obs;
  bool isFingerprint;
  var myPosts = {}.obs;
  var myLikes = [].obs;
  var otherUserMap = {}.obs;
  setOtherUserMap(String userId) async {
    Map map = await getUser(userId);
    this.otherUserMap.value = map;
  }

  setMyLikes(List map) {
    this.myLikes.value = map;
  }

  setMyPosts(Map map) {
    this.myPosts.value = map;
  }

  setFollowers(Map map) {
    this.followers.value = map;
  }

  setFollowing(Map map) {
    this.following.value = map;
  }

  setPosts(Map map) {
    this.posts.value = map;
  }

  setUserMap(Map map) {
    this.userMap.value = map;
  }

  String token;
  setToken(String value) {
    this.token = value;
    SPHelper.spHelper.saveToken(value);
  }

  var pr = ProgressDialogUtils.createProgressDialog(Get.context);

  Map myPost = {};
  Map commentpost = {};
  Map commentpostbyid = {};

  setPostMap(Map map) {
    this.myPost = map;
  }

  setcommentpost(Map map) {
    this.commentpost = map;
  }

  setcommentpostbyid(Map map) {
    this.commentpostbyid = map;
  }
}
