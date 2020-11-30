import 'dart:async';

import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/main.dart';
import 'package:bbmsg_mobile/main_page_mockup.dart';
import 'package:bbmsg_mobile/services/connectvity_service.dart';
import 'package:bbmsg_mobile/ui/pages/profile_edit.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:bbmsg_mobile/utils/custom_dialoug.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'services copy/shared_prefrences_helper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String token;
  AppGet appGet = Get.put(AppGet());
  getAllVariables() async {
    token = SPHelper.spHelper.getToken();
    appGet.setToken(token);
    if (token != null) {
      Map<String, dynamic> map =
          await retrieveUser(token: token, strategy: 'jwt');
      if (map == null) {
        token = null;
        SPHelper.spHelper.clearSp();
      } else {
        getFollowers(true);
        GetFollowing(true);
        getPosts(userId: '${map['user']['id']}');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getAllVariables();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        Get.off(ProfileEdit());
        // token == null ? Get.off(MainPage()) : Get.off(MainPageMock());
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error', titleKey: 'alert');
      }
    });
    return Scaffold(
        backgroundColor: const Color(0xff98b119),
        body: Container(
            decoration: BoxDecoration(
          color: primaryColor,
        )));
  }
}
