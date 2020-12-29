import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/ui/newPages/postdetails.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/insta_body.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/commentbyid.dart';

import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/addcomment.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/listpostcomment.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:string_validator/string_validator.dart';
import '../../story/insta_stories.dart';

class InstaList extends StatefulWidget {
  Function fun;
  InstaList(this.fun);
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  int griditm = 1;
  String isarabic;
  int liklocal=0;
  postimg(String txt, List img, int ind) {
    // print('media' + img[1]['url'].toString());

    if (img.isEmpty) {
      return InkWell(
        onTap: () {
          //  Get.to(PostDetailscr(
          //                               appGet.posts[ind]['id'].toString(),
          //                               appGet.posts[ind]['author']
          //                                       ['profile_picture']
          //                                   .toString(),
          //                               appGet.posts[ind]['author']['name']
          //                                   .toString(),
          //                                appGet.posts[ind]['media'][0]['url'].toString(),
          //                               appGet.posts[ind]['likes'].toString(),
          //                               appGet.posts[ind]['comments']
          //                                   .toString(),
          //                               appGet.posts[ind]['content'].toString(),
          //                             ));
        },
        child: Padding(
          padding: EdgeInsets.only(right: 25.w, left: 25.w),
          child: Text(
            txt,
            textAlign:
                isAlpha(txt.split(' ')[0]) ? TextAlign.left : TextAlign.right,
          ),
        ),
      );
    } else {
      print('photo');

      img.length > 1 ? griditm = 2 : griditm = 1;
      return InkWell(
        onTap: () {
          //  Get.to(PostDetailscr(
          //                             appGet.posts[ind]['id'].toString(),
          //                             appGet.posts[ind]['author']
          //                                     ['profile_picture']
          //                                 .toString(),
          //                             appGet.posts[ind]['author']['name']
          //                                 .toString(),
          //                             appGet.posts[ind]['media'][0]['url'].toString(),
          //                             appGet.posts[ind]['likes'].toString(),
          //                             appGet.posts[ind]['comments']
          //                                 .toString(),
          //                             appGet.posts[ind]['content'].toString(),
          //                           ));
        },
        child: Container(
            width: 200.w,
            child: Column(
              crossAxisAlignment: isAlpha(txt.split(' ')[0])
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                  child: Text(
                    txt,
                    textAlign: isAlpha(txt) ? TextAlign.left : TextAlign.right,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  height: 250.h,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: img[0]['url'].toString(),
                  ),
                ),
              ],
            )),
      );
    }
  }

  AppGet appGet = Get.find();
  // bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
      
    setState(() {});
    return Obx(() {
      return appGet.posts.isNullOrBlank
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: size.height - 100.h,
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: HeaderMock(widget.fun),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: appGet.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 16.0, 8.0, 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                appGet.setOtherUserMap(appGet
                                                    .posts[index]['author']
                                                        ['id']
                                                    .toString());

                                                Get.to(ProfilePage(
                                                  appGet.posts[index]['author']
                                                          ['name']
                                                      .toString(),
                                                ));
                                              },
                                              child: Row(
                                                children: [
                                                  ///////////////
                                                  appGet.posts[index]['author'][
                                                              'profile_picture'] !=
                                                          null
                                                      ? Container(
                                                          height: ScreenUtil()
                                                              .setWidth(40),
                                                          width: ScreenUtil()
                                                              .setWidth(40),
                                                          decoration:
                                                              new BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                new DecorationImage(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    image:
                                                                        CachedNetworkImageProvider(
                                                                      appGet
                                                                          .posts[
                                                                              index]
                                                                              [
                                                                              'author']
                                                                              [
                                                                              'profile_picture']
                                                                          .toString(),
                                                                    )),
                                                          ),
                                                        )
                                                      : Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: ScreenUtil()
                                                              .setWidth(40),
                                                          width: ScreenUtil()
                                                              .setWidth(40),
                                                          decoration:
                                                              new BoxDecoration(
                                                            color: primaryColor,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Text(
                                                            appGet.posts[index]
                                                                    ['author']
                                                                    ['name']
                                                                .toString()[0]
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                  new SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(150),
                                                        child: new Text(
                                                          appGet.posts[index]
                                                                  ['author']
                                                                  ['name']
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(150),
                                                        child: new Text(
                                                          // "10 min",
                                                          readTimestamp(DateTime
                                                              .parse(appGet
                                                                          .posts[
                                                                      index][
                                                                  'created_at'])),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[500]),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        new IconButton(
                                          icon: Icon(Icons.more_vert),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Get.to(PostDetailscr(
                                  //       appGet.posts[index]['id'].toString(),
                                  //       appGet.posts[index]['author']
                                  //               ['profile_picture']
                                  //           .toString(),
                                  //       appGet.posts[index]['author']['name']
                                  //           .toString(),
                                  //       appGet.posts[index]['media'].toString(),
                                  //       appGet.posts[index]['likes'].toString(),
                                  //       appGet.posts[index]['comments']
                                  //           .toString(),
                                  //       appGet.posts[index]['content'].toString(),
                                  //     ));
                                  //   },
                                  //   child: new Image.network(
                                  //     appGet.posts[index]['media'][0]['url'].toString(),
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                  postimg(
                                      appGet.posts[index]['content'].toString(),
                                      appGet.posts[index]['media'],
                                      index),
                                  Container(
                                    child: Postlike(
                                      appGet.posts[index]['id'],
                                      appGet.posts[index]['my_like'],
                                      appGet.posts[index]['likes'],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Container(
                                  //       child: appGet.posts[index]['id'] > 0
                                  //           ? Commentbyid(
                                  //               appGet.posts[index]['id'],
                                  //               appGet.posts[index]['comments'],
                                  //             )
                                  //           : Commentbyid(
                                  //               0,
                                  //               appGet.posts[index]['comments'],
                                  //             )),
                                  // ),
                                  Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(Listcommentpost(
                                        appGet.posts[index],
                                      ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 5, 0.0, 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          appGet.userMap['user']
                                                      ['profile_picture'] !=
                                                  null
                                              ? Container(
                                                  height:
                                                      ScreenUtil().setWidth(22),
                                                  width:
                                                      ScreenUtil().setWidth(22),
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: CachedNetworkImageProvider(
                                                          appGet.userMap['user']
                                                              [
                                                              'profile_picture']),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  alignment: Alignment.center,
                                                  height:
                                                      ScreenUtil().setWidth(30),
                                                  width:
                                                      ScreenUtil().setWidth(30),
                                                  decoration: new BoxDecoration(
                                                    color: primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Text(
                                                    appGet.userMap['user']
                                                            ['name']
                                                        .toString()[0]
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                          new SizedBox(
                                            width: 10.0,
                                          ),
                                          Addcomments(
                                              appGet.posts[index]['id']),
                                          SizedBox(width: 10.w)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                        readTimestamp(DateTime.parse(appGet
                                                .posts[index]['created_at']
                                                .toString())) +
                                            ' Ago',
                                        style: TextStyle(color: Colors.grey)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
    });
  }
}
