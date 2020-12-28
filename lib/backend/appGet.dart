import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/utils/ProgressDialogUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'dart:io';
class AppGet extends GetxController {
  double screenWidth;
  double screenHeight;
  var testArray = [1, 2, 3, 4, 5, 6, 7].obs;
  var isLoading = false.obs;
  var userMap = Map().obs;
  var followers = {}.obs;
  var following = {}.obs;
  var posts = [].obs;
  var story = Map().obs;

  Map testMap = {};
  var appBarTitleStyle = TextStyle().obs;
  bool isFingerprint;
  var myPosts = {}.obs;
  var myLikes = [].obs;
  var otherUserMap = {}.obs;
  var gLikes = [].obs;
  var usersMap = {}.obs;
  File postvideo;

  setUsersMap(Map map) {
    this.usersMap.value = map;
  }

  setOtherUserMap(String userId) async {
    Map map = await getUser(userId);
    this.otherUserMap.value = map;
    logger.e(otherUserMap);
  }
setStory(Map map) {
    this.story.value = map;
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

  setPosts(List list) {
    this.posts.value = list;
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
  var mapActivity = {}.obs;
  Map myPost = {};
  Map commentpost = {};
  Map commentpostbyid = {};
  Map commentpostbyidlist = {};
  Map commentreplytbyid = {};
  FocusNode commntFocusNode;
  FocusNode commntFocusNode2;
  int commentorreply;
  int replyid;
  setPostMap(Map map) {
    this.myPost = map;
  }

  setcommentpost(Map map) {
    this.commentpost = map;
  }

  setcommentpostbyid(Map map) {
    this.commentpostbyid = map;
  }

  setcommentreplytbyid(Map map) {
    this.commentreplytbyid = map;
  }

  setcommentreplytbyidlist(Map map) {
    this.commentpostbyidlist = map;
  }
}
