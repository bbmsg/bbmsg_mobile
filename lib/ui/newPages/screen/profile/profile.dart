import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/pages/app_settings.dart';
import 'package:bbmsg_mobile/ui/pages/followers_page.dart';
import 'package:bbmsg_mobile/ui/pages/following_page.dart';
import 'package:bbmsg_mobile/ui/pages/profile_edit.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Profilescreen extends StatelessWidget {
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appGet.userMap.isEmpty
          ? Container(child: Center(child: CircularProgressIndicator()))
          : DefaultTabController(
              length: 2,
              child: Scaffold(
                body: SafeArea(
                  child: Container(
                      child: Column(children: [
                    Container(
                      alignment: Alignment.center,
                      height: (appGet.screenHeight / 3) + 30.h,
                      decoration: BoxDecoration(
                          color: Color(0xff047AF2),
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.dstATop),
                              image: appGet.userMap['user']
                                          ['profile_picture'] !=
                                      null
                                  ? CachedNetworkImageProvider(
                                      appGet.userMap['user']['profile_picture'])
                                  : AssetImage('assets/pngs/back2.jpg'),
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
                                    print('hello');
                                    Get.to(AppSettings());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      'assets/svgs/Iconly-Light-Setting.svg',
                                      semanticsLabel: 'Acme Logo',
                                      height: 28.h,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ProfileEdit());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      'assets/svgs/edit.svg',
                                      semanticsLabel: 'Acme Logo',
                                      // color: Get.isDarkMode
                                      //     ? Colors.black
                                      //     : Colors.white,
                                      height: 25.h,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              appGet.userMap['user']['profile_picture'] != null
                                  ? Container(
                                      height: 150.h,
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 5.w),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  appGet.userMap['user']
                                                      ['profile_picture']),
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
                                        appGet.userMap['user']['name'][0]
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
                    Obx(() {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 20.h),
                        // color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${appGet.myPosts['total'] ?? 0}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  'Posts',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'second_header',
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                logger.e(appGet.followers);
                                Get.to(FollowersPage());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${appGet.followers['total'] ?? 0}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
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
                            GestureDetector(
                              onTap: () {
                                Get.to(FollowingPage());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${appGet.following['total'] ?? 0}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                  Text(
                                    'Following',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'second_header'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                    Container(
                        child: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'Posts',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Likes',
                            style: TextStyle(
                                // color: Get.isDarkMode
                                //     ? Colors.white
                                //     : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    )),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
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
                                      onTap: () {
                                        logger.e(appGet.myPosts['data'][index]);
                                      },
                                      child:
//
// appGet.myPosts['data'][index]['media'].first['url'].toString().substring(appGet.myPosts['data'][index]['media'].length - 3 )==
//                               'mp4'? VideoCard( appGet.myPosts['data'][index]['media']
//                                       .first['url']).toString():

                                          CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: appGet.myPosts['data']
                                                  .where((e) {
                                                    List images = e['media'];
                                                    return images.isNotEmpty;
                                                  })
                                                  .toList()[index]['media']
                                                  .first['url']),
                                    );
                                  },
                                )
                              : Container(),
                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 2.w,
                                    mainAxisSpacing: 2.h),
                            itemCount: appGet.myLikes.where((e) {
                              if (e != null) {
                                List images = e['media'];
                                return images.isNotEmpty;
                              } else {
                                return false;
                              }
                            }).length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.red,
                                child: CachedNetworkImage(
                                  imageUrl: appGet.myLikes
                                      .where((e) {
                                        if (e != null) {
                                          List images = e['media'];
                                          return images.isNotEmpty;
                                        } else {
                                          return false;
                                        }
                                      })
                                      .toList()[index]['media']
                                      .first['url'],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ]),
                      ),
                    )

                    // Expanded(
                    //   child: TabBarView(children: [
                    //     appGet.myPosts['data'] != null
                    //         ? GridView.builder(
                    //             gridDelegate:
                    //                 SliverGridDelegateWithFixedCrossAxisCount(
                    //                     crossAxisCount: 3,
                    //                     crossAxisSpacing: 2.w,
                    //                     mainAxisSpacing: 2.h),
                    //             itemCount: appGet.myPosts['data'].where((e) {
                    //               List images = e['media'];
                    //               return images.isNotEmpty;
                    //             }).length,
                    //             itemBuilder: (context, index) {
                    //               return GestureDetector(
                    //                 onTap: () {
                    //                   print(appGet.myPosts['data'][index]['media']
                    //                       .first['url']);
                    //                 },
                    //                 child: CachedNetworkImage(
                    //                     fit: BoxFit.cover,
                    //                     imageUrl: appGet
                    //                         .myPosts['data'][index]['media']
                    //                         .first['url']),
                    //               );
                    //             },
                    //           )
                    //         : Container(),
                    //     GridView.builder(
                    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 3,
                    //           crossAxisSpacing: 2.w,
                    //           mainAxisSpacing: 2.h),
                    //       itemCount: appGet.myLikes.where((e) {
                    //         Logger().e('hhhhhhhh $e');
                    //         List images = e['media'];
                    //         return images.isNotEmpty;
                    //       }).length,
                    //       itemBuilder: (context, index) {
                    //         return CachedNetworkImage(
                    //             imageUrl: appGet.myLikes
                    //                 .where((e) {
                    //                   Logger().e('hhhhhhhh $e');
                    //                   List images = e['media'];
                    //                   return images.isNotEmpty;
                    //                 })
                    //                 .toList()[index]['media']
                    //                 .first['url']);
                    //       },
                    //     ),
                    //   ]),
                    // )
                  ])),
                ),
              ),
            );
    });
  }
}
