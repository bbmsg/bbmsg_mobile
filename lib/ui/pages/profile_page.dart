import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProfilePage extends StatelessWidget {
  AppGet appGet = Get.find();
  String name;
  ProfilePage(this.name);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return appGet.otherUserMap['name'] == null
          ? Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: primaryColor,
                  ),
                ),
                centerTitle: true,
                title: new Text(
                  "$name Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: SafeArea(
                child: Container(
                    child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 250.h,
                          decoration: BoxDecoration(
                              color: Color(0xff047AF2),
                              image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.dstATop),
                                  image:
                                      appGet.otherUserMap['profile_picture'] !=
                                              null
                                          ? CachedNetworkImageProvider(appGet
                                              .otherUserMap['profile_picture'])
                                          : AssetImage('assets/pngs/back2.jpg'),
                                  fit: BoxFit.cover)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              appGet.otherUserMap['profile_picture'] != null
                                  ? Container(
                                      height: 150.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 5.w),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  appGet.otherUserMap[
                                                      'profile_picture']),
                                              fit: BoxFit.cover)),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      height: 150.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        border: Border.all(
                                            color: Colors.white, width: 5.w),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        appGet.otherUserMap['name'][0]
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(40,
                                                allowFontScalingSelf: true),
                                            color: Colors.white),
                                      ),
                                    ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Text(
                                appGet.otherUserMap['name'],
                                style: TextStyle(
                                    fontFamily: 'second_header',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              appGet.otherUserMap['address'] != null
                                  ? Text(appGet.otherUserMap['address'],
                                      style: TextStyle(
                                          fontFamily: 'second_header',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17,
                                          color: Colors.white))
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${appGet.otherUserMap['posts'] ?? 0}',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 20),
                                  ),
                                  Text(
                                    'Posts',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'second_header'),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(appGet.userMap);
                                  // Get.to(FollowersPage());
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${appGet.otherUserMap['followers'] ?? 0}',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 20),
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'second_header'),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${appGet.otherUserMap['following'] ?? 0}',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 20),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'second_header'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        ////////////////
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 20.h),
                          height: 50.h,
                          width: 800.w,
                          child: RaisedButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                appGet.otherUserMap['isFollowedByMe'] != null
                                    ? 'UnFollow'
                                    : 'Follow',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                // logger.e(appGet.otherUserMap);
                                // await getFollowing(true);
                                // logger.e(appGet.following);
                                Logger().e(appGet.otherUserMap);
                                logger.e(appGet.userMap);
                                if (appGet.otherUserMap['isFollowedByMe'] ==
                                    null) {
                                  followUser(
                                      appGet.otherUserMap['id'].toString(),
                                      false,
                                      appGet.otherUserMap['id'].toString());
                                } else {
                                  var followId = appGet
                                      .otherUserMap['isFollowedByMe']['id'];
                                  followUser(followId.toString(), true,
                                      appGet.otherUserMap['id'].toString());
                                }

                                // print(appGet.otherUserMap);
                              }),
                        ),
                        Divider(),
                        EditableCustomText('Name',
                            appGet.otherUserMap['name'] ?? 'Not Defined'),

                        Divider(),
                        EditableCustomText('Address',
                            appGet.otherUserMap['address'] ?? 'Not Defined'),
                        Divider(),
                        EditableCustomText('Email',
                            appGet.otherUserMap['email'] ?? 'Not Defined'),
                        Divider(),
                        EditableCustomText(
                          'Mobile',
                          appGet.otherUserMap['phone_number'] ?? 'Not Defined',
                        ),
                        Divider(),
                        EditableCustomText(
                          'Gender',
                          appGet.otherUserMap['gender'] ?? 'Not Defined',
                        ),
                        Divider(),
                        EditableCustomText('BirthDate',
                            appGet.otherUserMap['birthdate'] ?? 'Not Defined'),
                      ]),
                )),
              ),
            );
    });
  }
}

class EditableCustomText extends StatefulWidget {
  String title;
  String value;

  EditableCustomText(this.title, this.value);

  @override
  _EditableTextState createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableCustomText> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          Text(widget.value,
              style: TextStyle(color: primaryColor, fontSize: 17))
        ],
      ),
    );
  }
}
