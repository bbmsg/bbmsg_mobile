import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  CustomAppBar(this.title);
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // border: Border.all(color: Colors.transparent),
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
        ),
      ),
      title: Text(
        title,
      ),
    );
    // return CupertinoNavigationBar(
    //   backgroundColor: Colors.transparent,
    //   border: Border.all(color: Colors.transparent),
    //   middle: Obx(() {
    //     return Text(
    //       title,
    //       style: appGet.appBarTitleStyle.value,
    //     );
    //   }),
    // );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(CupertinoNavigationBar().preferredSize.height);
}
