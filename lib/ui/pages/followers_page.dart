import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/widgets/follow_user_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowersPage extends StatelessWidget {
  AppGet appGet = Get.find();
  followFun(String userId, String followId, bool isFollowed) {
    followUser(followId, isFollowed, userId);
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
          return ListView.builder(
            itemCount: appGet.followers['total'],
            itemBuilder: (context, index) {
              return FollowUserWidget(
                address: appGet.followers['data'][index]['user']['address'] ??
                    'No address defined',
                imageUrl: appGet.followers['data'][index]['user']
                    ['profile_picture'],
                userName: appGet.followers['data'][index]['user']['name'],
                isFollow: appGet.followers['data'][index]['user']
                    ['isFollowedByMe'],
                fun: followFun,
                id: appGet.followers['data'][index]['user']['id'].toString(),
              );
            },
          );
        }),
      ),
    );
  }
}
