import 'dart:ui';

import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';

class PostDetailsa extends StatelessWidget {
  int index;
  PostDetailsa(this.index);

  TextEditingController replaycontroller = new TextEditingController();
  AppGet appGet = Get.find();

  TextEditingController commentcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        appGet.postsComments.value = [];
        return Future.value(true);
      },
      child: Scaffold(
        appBar: Headbar(
          'Post Details',
          3,
          createPost,
          isCreatePost: true,
        ),
        body: Obx(() {
          // getAcommentlist(appGet.posts[index]['id']);
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostHeader(index),
                        appGet.posts[index]['media'].isEmpty
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                color: primaryColor,
                                height: 300.h,
                                alignment: Alignment.center,
                                child: Text(
                                  appGet.posts[index]['content'],
                                  textAlign:
                                      isAlpha(appGet.posts[index]['content'])
                                          ? TextAlign.right
                                          : TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: isAlpha(appGet.posts[index]
                                            ['content']
                                        .toString()
                                        .toLowerCase()
                                        .removeAllWhitespace)
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w, bottom: 10.h),
                                    child: Text(
                                      appGet.posts[index]['content'],
                                      textAlign: isAlpha(
                                              appGet.posts[index]['content'])
                                          ? TextAlign.left
                                          : TextAlign.right,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  PostImages(
                                    images: appGet.posts[index]['media'],
                                  ),
                                ],
                              ),
                        PostLikeAndCommentWidget(index),
                        appGet.postsComments.isNotEmpty
                            ? CommentsList(appGet.postsComments, false)
                            : Container(
                                height: 200.h,
                                alignment: Alignment.center,
                                child: Text(
                                    'No comments! Write the first comment')),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[100],
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: replaycontroller,
                          decoration: InputDecoration(
                              hintText: 'Add a comment...',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            createComment(appGet.posts[index]['id'],
                                replaycontroller.text);
                            replaycontroller.clear();
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CommentsList extends StatelessWidget {
  List comments;
  bool isFirst;
  CommentsList(this.comments, this.isFirst);
  Widget generateComments() {
    List<Widget> usersComments = comments.map((e) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Row(
          children: [
            isFirst
                ? Text(
                    e['author']['name'].toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : e['author']['profile_picture'] != null
                    ? Container(
                        height: ScreenUtil().setWidth(30),
                        width: ScreenUtil().setWidth(30),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                e['author']['profile_picture'].toString(),
                              )),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().setWidth(30),
                        width: ScreenUtil().setWidth(30),
                        decoration: new BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          e['author']['name'].toString()[0].toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
            SizedBox(
              width: 10.w,
            ),

            Expanded(
              child: Text(
                e['content'],
                // style: Styles.titleTextStyle
                //     .copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            // GestureDetector(onTap: (){

            // },
            //               child: SvgPicture.asset(e['my_like'] == 0
            //       ? 'assets/svgs/heart.svg'
            //       : 'assets/svgs/Shape.svg'),
            // )
          ],
        ),
      );
    }).toList();
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: 5.h,
        ),
        child: Column(
          children: usersComments,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: generateComments(),
    );
  }
}

class PostHeader extends StatelessWidget {
  int index;
  PostHeader(this.index);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
      child: GestureDetector(
        onTap: () {
          appGet
              .setOtherUserMap(appGet.posts[index]['author']['id'].toString());

          Get.to(ProfilePage(
            appGet.posts[index]['author']['name'].toString(),
          ));
        },
        child: Row(
          children: [
            ///////////////
            appGet.posts[index]['author']['profile_picture'] != null
                ? Container(
                    height: ScreenUtil().setWidth(40),
                    width: ScreenUtil().setWidth(40),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            appGet.posts[index]['author']['profile_picture']
                                .toString(),
                          )),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setWidth(40),
                    width: ScreenUtil().setWidth(40),
                    decoration: new BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      appGet.posts[index]['author']['name']
                          .toString()[0]
                          .toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
            new SizedBox(
              width: 10.0,
            ),
            Column(
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(150),
                  child: new Text(
                    appGet.posts[index]['author']['name'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(150),
                  child: new Text(
                    // "10 min",
                    readTimestamp(
                        DateTime.parse(appGet.posts[index]['created_at'])),
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ],
            ),
            Spacer(),
            appGet.posts[index]['author']['id'] == appGet.userMap['user']['id']
                ? GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      double left = details.globalPosition.dx;
                      double top = details.globalPosition.dy;
                      var x = await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(left, top, 0, 0),
                        items: [
                          PopupMenuItem<String>(
                              child: const Text('Delete post'),
                              value: 'delete'),
                        ],
                        elevation: 8.0,
                      );
                      if (x == 'delete') {
                        deletepost(appGet.posts[index]['id'], index);
                        Get.back();
                      }
                    },
                    child: Icon(Icons.more_vert))
                : GestureDetector(
                    onTapDown: (TapDownDetails details) async {
                      double left = details.globalPosition.dx;
                      double top = details.globalPosition.dy;
                      var x = await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(left, top, 0, 0),
                        items: [
                          PopupMenuItem<String>(
                              child: const Text('Block'), value: 'block'),
                          PopupMenuItem<String>(
                              child: const Text('Report post'),
                              value: 'report'),
                        ],
                        elevation: 8.0,
                      );
                      if (x == 'block') {
                        blockUser(appGet.posts[index]['author']['id']);
                        Get.back();
                      } else if (x == 'report') {
                        reportPost(appGet.posts[index]['id'], index);
                        Get.back();
                      }
                    },
                    child: Icon(
                      Icons.more_horiz,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class PostImages extends StatefulWidget {
  List images;

  PostImages({this.images});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostImages> {
  int indexPage = 0;

  List<Widget> buildSlider() {
    final List<Widget> imageSliders = widget.images
        .map((item) => Container(
              child: Container(
                // margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl: item['url'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/pngs/error.png',
                              height: 25,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('error_media'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ))
        .toList();

    return imageSliders;
  }

  @override
  Widget build(BuildContext context) {
    // List<String> tags =   widget.postMap['tags'];
    // TODO: implement build
    return widget.images.length > 1
        ? CarouselSlider(
            items: buildSlider(),
            options: CarouselOptions(
              height: 300.h,
              viewportFraction: 1,
              initialPage: 0,
              reverse: false,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                this.indexPage = index;
                setState(() {});
              },
            ))
        : Container(
            height: 300.h,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.images.first['url'],
              fit: BoxFit.cover,
            ),
          );
  }
}
