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
  Map userMap = {};
  var followers = {}.obs;
  var following = {}.obs;
  var posts = {}.obs;
  Map testMap = {};
  var appBarTitleStyle = TextStyle().obs;
  bool isFingerprint;
  var myPosts = {}.obs;
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
    this.userMap = map;
  }

  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJpYXQiOjE2MDUyNzgyNTQsImV4cCI6MTYzNjgxNDI1NCwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo3NDI1IiwiaXNzIjoiZmVhdGhlcnMiLCJzdWIiOiIyIiwianRpIjoiNjk0MDFiOWUtMDBmZC00MDU1LTg5OTQtOWNhNTBiMWU4YTQyIn0.RroVEVR8QWrUN9gb1YC331FGvQUZQU8qW3QF1AgfZwY";

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
