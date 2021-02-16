import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/custom_image_editor.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/elementstroy/pageviewstory.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'instalist/insta_list.dart';

class InstaBody extends StatelessWidget {
  Function fun;
  InstaBody(this.fun);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InstaList(fun);
  }
}

class HeaderMock extends StatelessWidget {
  Function fun;
  HeaderMock(this.fun);
  AppGet appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appGet.userMap['user']['profile_picture'] != null
                    ? Container(
                        height: ScreenUtil().setWidth(55),
                        width: ScreenUtil().setWidth(55),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                appGet.userMap['user']['profile_picture']
                                    .toString(),
                              )),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setWidth(60),
                        width: ScreenUtil().setWidth(60),
                        decoration: new BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          appGet.userMap['user']['name']
                              .toString()[0]
                              .toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                SizedBox(
                  width: 8.0.w,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          width: ScreenUtil().setWidth(150),
                          child: new Text(
                            appGet.userMap['user']['name'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            // fun();
                            logger.e(appGet.story['data']);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: Alignment.centerLeft,
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Color(0xff9B9B9B)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'What\'s in your mind?',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          appGet.story.isEmpty
              ? Container()
              : appGet.story['data'].length > 0
                  ? Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// first element where is the user image and add on it
                          appGet.userMap['user']['profile_picture'] != null
                              ? InkWell(
                                  onTap: () {
                                    print('object');
                                    Get.to(CustomImageEditorPro(
                                      appBarColor: Colors.blue,
                                      bottomBarColor: Colors.blue,
                                    ));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 110.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xff047AF2),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.4),
                                              BlendMode.dstATop),
                                          image: CachedNetworkImageProvider(
                                              appGet.userMap['user']
                                                  ['profile_picture']),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      // color: Colors.white,
                                    )),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    print('object');
                                    // Get.to(Opennewstory());
                                    Get.to(CustomImageEditorPro(
                                      appBarColor: Colors.blue,
                                      bottomBarColor: Colors.blue,
                                    ));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 110.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff047AF2),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.4),
                                              BlendMode.dstATop),
                                          image: AssetImage(
                                              'assets/pngs/back2.jpg'),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                                  )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: Container(
                              height: 110.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: appGet.story['data'].length,
                                itemBuilder: (context, index) {
                                  return appGet.story['data'][index]['total'] !=
                                          0
                                      ? InkWell(
                                          onTap: () {
                                            Get.to(Pageviewstory(
                                                appGet.story['data']));
                                          },
                                          child: Container(
                                            height: 110.h,
                                            width: 80.w,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: new DecorationImage(
                                                  colorFilter: ColorFilter.mode(
                                                      Colors.black
                                                          .withOpacity(0.2),
                                                      BlendMode.darken),
                                                  fit: BoxFit.cover,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                    appGet.story['data'][index]
                                                            ['stories'][0]
                                                            ['media']['url']
                                                        .toString(),
                                                  )),
                                            ),
                                            child: Text(
                                              appGet.story['data'][index]
                                                  ['author']['name'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )

                                      // InkWell(
                                      //     onTap: () {
                                      //       logger.e(appGet.story['data'][index]
                                      //           ['author']['profile_picture']);
                                      //       // Get.to(Pageviewstory(
                                      //       //     appGet.story['data']));
                                      //     },
                                      //     child:

                                      //     Container(
                                      //       margin: EdgeInsets.symmetric(
                                      //           horizontal: 4.w),
                                      //       width: 70.w,
                                      //       decoration: BoxDecoration(
                                      //         shape: BoxShape.circle,
                                      //         boxShadow: [
                                      //           BoxShadow(
                                      //             color: Colors.grey
                                      //                 .withOpacity(0.1),
                                      //             spreadRadius: 0.2,
                                      //             blurRadius: 5,
                                      //             offset: Offset(0,
                                      //                 3), // changes position of shadow
                                      //           ),
                                      //         ],
                                      //         color: Color(0xff047AF2),
                                      //         image: DecorationImage(
                                      //             image: appGet.story['data']
                                      //                                 [index]
                                      //                             ['author'][
                                      //                         'profile_picture'] ==
                                      //                     null
                                      //                 ? Container(
                                      //                     child: Text(appGet
                                      //                         .story['data']
                                      //                             [index]
                                      //                             ['author']
                                      //                             ['name'][0]
                                      //                         .toString()
                                      //                         .toUpperCase()),
                                      //                   )
                                      //                 : CachedNetworkImageProvider(
                                      //                     appGet.story['data']
                                      //                             [index]
                                      //                             ['author'][
                                      //                             'profile_picture']
                                      //                         .toString(),
                                      //                   ),
                                      //             fit: BoxFit.cover),
                                      //       ),
                                      //       child: Center(
                                      //         child: Text(
                                      //           appGet.story['data'][index]
                                      //                   ['stories'][0]['content']
                                      //               .toString(),
                                      //           textAlign: TextAlign.center,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   )
                                      : InkWell(
                                          onTap: () {
                                            Get.to(Pageviewstory(
                                                appGet.story['data']));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            height: 110.h,
                                            width: 80.w,
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: primaryColor,
                                            ),
                                            child: Text(
                                              appGet.story['data'][index]
                                                      ['author']['name']
                                                  .toString()
                                                  .split(' ')[0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.centerLeft,
                      child: appGet.userMap['user']['profile_picture'] != null
                          ? InkWell(
                              onTap: () {
                                print('object');
                                Get.to(CustomImageEditorPro(
                                  appBarColor: Colors.blue,
                                  bottomBarColor: Colors.blue,
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                height: 110.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xff047AF2),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.4),
                                          BlendMode.dstATop),
                                      image: CachedNetworkImageProvider(appGet
                                          .userMap['user']['profile_picture']),
                                      fit: BoxFit.cover),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  // color: Colors.white,
                                )),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                print('object');
                                // Get.to(Opennewstory());
                                Get.to(CustomImageEditorPro(
                                  appBarColor: Colors.blue,
                                  bottomBarColor: Colors.blue,
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4.w),
                                height: 110.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff047AF2),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.4),
                                          BlendMode.dstATop),
                                      image:
                                          AssetImage('assets/pngs/back2.jpg'),
                                      fit: BoxFit.cover),
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              )),
                    ),
        ],
      );
    });
  }
}
