import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/ui/pages/app_settings.dart';
import 'package:bbmsg_mobile/ui/pages/profile_edit.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Profilescreen extends StatelessWidget {
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(() {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: appGet.screenHeight / 3,
                    decoration: BoxDecoration(
                        color: Color(0xff047AF2),
                        image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.dstATop),
                            image: appGet.userMap.value['user']
                                        ['profile_picture'] !=
                                    null
                                ? CachedNetworkImageProvider(appGet
                                    .userMap.value['user']['profile_picture'])
                                : AssetImage('assets/pngs/logo.png'),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(AppSettings());
                                },
                                child: SvgPicture.asset(
                                  'assets/svgs/Iconly-Light-Setting.svg',
                                  semanticsLabel: 'Acme Logo',
                                  color: Colors.white,
                                  height: 20.h,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(ProfileEdit());
                                },
                                child: SvgPicture.asset(
                                  'assets/svgs/edit.svg',
                                  semanticsLabel: 'Acme Logo',
                                  color: Colors.white,
                                  height: 20.h,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 150.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 5.w),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: appGet.userMap['user']
                                                  ['profile_picture'] !=
                                              null
                                          ? CachedNetworkImageProvider(
                                              appGet.userMap['user']
                                                  ['profile_picture'])
                                          : AssetImage('assets/pngs/logo.png'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              appGet.userMap['user']['name'],
                              style: TextStyle(
                                  fontFamily: 'second_header',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            appGet.userMap['user']['address'] != null
                                ? Text(appGet.userMap['user']['address'],
                                    style: TextStyle(
                                        fontFamily: 'second_header',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17,
                                        color: Colors.white))
                                : Container(),
                            // IconButton(
                            //     icon: Icon(Icons.insert_chart),
                            //     onPressed: () {
                            //       print(appGet.userMap['user']['name']);
                            //     })
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${appGet.myPosts['total']}',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 20),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'second_header'),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${appGet.followers['total']}',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 20),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'second_header'),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${appGet.following['total']}',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 20),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'second_header'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: TabBar(tabs: [
                    Tab(
                      child: Text(
                        'Posts',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Likes',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ])),
                  Expanded(
                    child: TabBarView(children: [
                      appGet.myPosts['data'] != null
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 2.w,
                                      mainAxisSpacing: 2.h),
                              itemCount: appGet.myPosts['data'].where((e) {
                                List images = e['media'];
                                return images.isNotEmpty;
                              }).length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: appGet
                                          .myPosts['data'][index]['media']
                                          .first['url']),
                                );
                              },
                            )
                          : Container(),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 2.w,
                            mainAxisSpacing: 2.h),
                        itemCount: appGet.myLikes.where((e) {
                          Logger().e('hhhhhhhh $e');
                          List images = e['media'];
                          return images.isNotEmpty;
                        }).length,
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                              imageUrl:
                                  appGet.myLikes[index]['media'].first['url']);
                        },
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
