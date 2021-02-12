import 'dart:io';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/custom_image_editor.dart';
import 'package:bbmsg_mobile/utils/ProgressDialogUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestApi extends StatefulWidget {
  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  @override
  initState() {
    super.initState();
    Get.put(AppGet());
  }

  ArsProgressDialog pr = ArsProgressDialog(Get.context,
      blur: 2,
      backgroundColor: Color(0x33000000),
      loadingWidget: Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(
            radius: 20,
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(onPressed: () {
            ProgressDialogUtils.pr.show();
          })
        ],
      ),
    ));
  }
}

class User {
  String imageUrl;
  String userName;
  String address;
  bool isFollow;
  User({this.address, this.imageUrl, this.userName, this.isFollow});
}
