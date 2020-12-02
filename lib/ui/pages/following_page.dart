import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/widgets/follow_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowingPage extends StatelessWidget {
  AppGet appGet = Get.find();
  followUserFun(String id) {
    unFollowUser(id);
    getFollowing(true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Followers',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.h),
        child: Obx(() {
          return appGet.following['data'] != null
              ? ListView.builder(
                  itemCount: appGet.following['total'],
                  itemBuilder: (context, index) {
                    return FollowingWidget(
                      address: appGet.following['data'][index]['user']
                          ['address'],
                      imageUrl: appGet.following['data'][index]['user']
                          ['profile_picture'],
                      userName: appGet.following['data'][index]['user']['name'],
                      isFollow: appGet.following['data'][index]['user']
                          ['isFollowingMe'],
                      fun: followUserFun,
                      id: appGet.following['data'][index]['id'].toString(),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
