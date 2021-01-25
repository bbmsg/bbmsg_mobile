import 'dart:async';

import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bbmsg_mobile/services/connectvity_service.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/testApi.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/insta_home.dart';
import 'package:bbmsg_mobile/ui/pages/app_settings.dart';
import 'package:bbmsg_mobile/utils/custom_dialoug.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bbmsg_mobile/ui/pages/following_page.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String token;
  AppGet appGet = Get.put(AppGet());
  getAllVariables() async {
    token = SPHelper.spHelper.getToken();
    logger.e(token);

    appGet.setToken(token);

    if (token != null) {
      Map<String, dynamic> map =
          await retrieveUser(token: token, strategy: 'jwt');

      if (map == null) {
        // case the user has been deleted from the database but it still saved in the user sp
        token = null;
        SPHelper.spHelper.clearSp();
      } else {
        getFollowers(true);
        getFollowing(true);
        getPosts();
        getstory('30');
        getMyPosts(myId: '${map['user']['id']}');
        getMyLikes(myId: '${map['user']['id']}');
        getUsers();
        getActivity();
        getAllBlocks();
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
        // logger.e(appGet.userMap['user']['profile_picture']);
        // Get.to(TestApi());
        token == null ? Get.off(MainPage()) : Get.off(InstaHome(0));
        // token == null ? Get.off(MainPage()) : Get.off(TestApi());
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error', titleKey: 'alert');
      }
    });
    return Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Container(
              height: 200.h,
              width: 200.h,
              alignment: Alignment.center,
              child: Image.asset('assets/pngs/logo.png'),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
        ));
  }
}

//mop@mop.com
//Admin@2020
