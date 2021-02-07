import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/utils/ProgressDialogUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'dart:io';

class AppGet extends GetxController {
  File profileUserImage;
  setProfileEditImage(File file) {
    profileUserImage = file;
    update();
  }

  int numberOfStories;
  var isDarkMode = false.obs;
  var acceptConditions = false.obs;
  var postsComments = [].obs;

  likePost(int index, int id) {
    posts[index]['my_like'] = id;
    posts[index]['likes']++;
    update();
  }

  desLikePost(int index) {
    appGet.posts[index]['my_like'] = 0;
    appGet.posts[index]['likes']--;
    update();
  }

  int postsCount = 0;
  double screenWidth;
  double screenHeight;
  var testArray = [1, 2, 3, 4, 5, 6, 7].obs;
  var isLoading = false.obs;
  var userMap = Map().obs;
  var followers = {}.obs;
  var following = {}.obs;
  var posts = [].obs;
  var story = Map().obs;
  var completcycle = false.obs;

  Map testMap = {};
  var appBarTitleStyle = TextStyle().obs;
  bool isFingerprint;
  var myPosts = {}.obs;
  var myLikes = [].obs;
  var otherUserMap = {}.obs;
  var gLikes = [].obs;
  var usersMap = {}.obs;
  File postvideo;
  int currentPage = 0;
  PageController pagcontroller = PageController(initialPage: 0);

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

  int limit = 10;
  int skip = 0;
  setPosts(List list) {
    this.posts.addAll(list);
    // update();
  }

  int postIndex;
  var blockMap = {}.obs;
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
