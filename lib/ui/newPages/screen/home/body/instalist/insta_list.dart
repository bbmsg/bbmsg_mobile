import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/items_fetcher.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/insta_body.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/listpostcomment.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';

class InstaList extends StatefulWidget {
  Function fun;
  InstaList(this.fun);
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  AppGet appGet = Get.find();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  ItemFetcher _itemFetcher;

  bool _isLoading = true;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _itemFetcher = ItemFetcher(
      count: appGet.postsCount,
      itemsPerPage: 10,
    );
    _isLoading = true;
    _hasMore = true;
    _loadMore();
  }

  void _loadMore() {
    _isLoading = true;
    _itemFetcher.fetch().then((List fetchedList) {
      if (fetchedList.isEmpty) {
        setState(() {
          _isLoading = false;
          _hasMore = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          appGet.posts.addAll(fetchedList);
        });
      }
    });
  }

  int griditm = 1;
  String isarabic;
  int liklocal = 0;
  Widget postimge(String txt, List img, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        appGet.posts[index]['media'].isNotEmpty
            ? Column(
                crossAxisAlignment: isAlpha(appGet.posts[index]['content']
                        .toString()
                        .toLowerCase()
                        .removeAllWhitespace)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                    child: Text(
                      appGet.posts[index]['content'],
                      textAlign: isAlpha(appGet.posts[index]['content'])
                          ? TextAlign.left
                          : TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      getAcommentlist(appGet.posts[index]['id']);
                      Get.to(PostDetailsa(index));
                    },
                    child: PostImages(
                      images: appGet.posts[index]['media'],
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: () {
                  getAcommentlist(appGet.posts[index]['id']);
                  Get.to(PostDetailsa(index));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  color: primaryColor,
                  height: 300.h,
                  alignment: Alignment.center,
                  child: Text(
                    appGet.posts[index]['content'],
                    textAlign: isAlpha(appGet.posts[index]['content'])
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
        PostLikeAndCommentWidget(index),

        //TODO this comment
        CommentsList(appGet.posts[index]['comments']['data'], true),
      ],
    );
  }

  // bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    setState(() {});
    return Obx(() {
      return appGet.posts.isNullOrBlank
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Container(
              padding: EdgeInsets.only(bottom: 20),
              height: size.height - 100.h,
              child: ListView(
                children: [
                  Container(
                    child: HeaderMock(widget.fun),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _hasMore
                            ? appGet.postsCount + 1
                            : appGet.postsCount,
                        // itemCount: appGet.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          // if (appGet.limit == 10) {
                          //   logger.e('dddddddddddddddddddddddddddddddd');
                          //   appGet.limit += 10;
                          //   appGet.skip += 10;
                          //   getPosts(limit: appGet.limit, skip: appGet.skip);
                          // }

                          if (index >= appGet.posts.length) {
                            if (!_isLoading) {
                              _loadMore();
                            }
                            return Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                                height: 24,
                                width: 24,
                              ),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0)),
                            margin: EdgeInsets.symmetric(vertical: 2.h),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        appGet.setOtherUserMap(appGet
                                            .posts[index]['author']['id']
                                            .toString());

                                        Get.to(ProfilePage(
                                          appGet.posts[index]['author']['name']
                                              .toString(),
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          ///////////////
                                          appGet.posts[index]['author']
                                                      ['profile_picture'] !=
                                                  null
                                              ? Container(
                                                  height:
                                                      ScreenUtil().setWidth(40),
                                                  width:
                                                      ScreenUtil().setWidth(40),
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          appGet.posts[index]
                                                                  ['author'][
                                                                  'profile_picture']
                                                              .toString(),
                                                        )),
                                                  ),
                                                )
                                              : Container(
                                                  alignment: Alignment.center,
                                                  height:
                                                      ScreenUtil().setWidth(40),
                                                  width:
                                                      ScreenUtil().setWidth(40),
                                                  decoration: new BoxDecoration(
                                                    color: primaryColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Text(
                                                    appGet.posts[index]
                                                            ['author']['name']
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
                                          Column(
                                            children: [
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(150),
                                                child: new Text(
                                                  appGet.posts[index]['author']
                                                          ['name']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(150),
                                                child: new Text(
                                                  // "10 min",
                                                  readTimestamp(DateTime.parse(
                                                      appGet.posts[index]
                                                          ['created_at'])),
                                                  style: TextStyle(
                                                      color: Colors.grey[500]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          appGet.posts[index]['author']['id'] ==
                                                  appGet.userMap['user']['id']
                                              ? GestureDetector(
                                                  onTapDown: (TapDownDetails
                                                      details) async {
                                                    double left = details
                                                        .globalPosition.dx;
                                                    double top = details
                                                        .globalPosition.dy;
                                                    var x = await showMenu(
                                                      context: context,
                                                      position:
                                                          RelativeRect.fromLTRB(
                                                              left, top, 0, 0),
                                                      items: [
                                                        PopupMenuItem<String>(
                                                            child: const Text(
                                                                'Delete post'),
                                                            value: 'delete'),
                                                      ],
                                                      elevation: 8.0,
                                                    );
                                                    if (x == 'delete') {
                                                      deletepost(
                                                          appGet.posts[index]
                                                              ['id'],
                                                          index);
                                                    }
                                                  },
                                                  child: Icon(Icons.more_vert))
                                              : GestureDetector(
                                                  onTapDown: (TapDownDetails
                                                      details) async {
                                                    double left = details
                                                        .globalPosition.dx;
                                                    double top = details
                                                        .globalPosition.dy;
                                                    var x = await showMenu(
                                                      context: context,
                                                      position:
                                                          RelativeRect.fromLTRB(
                                                              left, top, 0, 0),
                                                      items: [
                                                        PopupMenuItem<String>(
                                                            child: const Text(
                                                                'Block'),
                                                            value: 'block'),
                                                        PopupMenuItem<String>(
                                                            child: const Text(
                                                                'Report post'),
                                                            value: 'report'),
                                                      ],
                                                      elevation: 8.0,
                                                    );
                                                    if (x == 'block') {
                                                      blockUser(
                                                          appGet.posts[index]
                                                              ['author']['id']);
                                                    } else if (x == 'report') {
                                                      reportPost(
                                                          appGet.posts[index]
                                                              ['id'],
                                                          index);
                                                    }
                                                  },
                                                  child:
                                                      Icon(Icons.more_horiz)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onDoubleTap: () {
                                      appGet.posts[index]['my_like'] == 0
                                          ? like(
                                              appGet.posts[index]['id'], index)
                                          : removelike(
                                              appGet.posts[index]['my_like'],
                                              index);
                                    },
                                    child: postimge(
                                        appGet.posts[index]['content']
                                            .toString(),
                                        appGet.posts[index]['media'],
                                        index),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {

                                  // Get.to(PostDetailsa(
                                  //   index,
                                  // ));
                                  //   },
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.fromLTRB(
                                  //         16.0, 5, 0.0, 8.0),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.start,
                                  //       children: <Widget>[
                                  //         appGet.userMap['user']
                                  //                     ['profile_picture'] !=
                                  //                 null
                                  //             ? Container(
                                  //                 height:
                                  //                     ScreenUtil().setWidth(22),
                                  //                 width:
                                  //                     ScreenUtil().setWidth(22),
                                  //                 decoration: new BoxDecoration(
                                  //                   shape: BoxShape.circle,
                                  //                   image: new DecorationImage(
                                  //                     fit: BoxFit.fill,
                                  //                     image: CachedNetworkImageProvider(
                                  //                         appGet.userMap['user']
                                  //                             [
                                  //                             'profile_picture']),
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             : Container(
                                  //                 alignment: Alignment.center,
                                  //                 height:
                                  //                     ScreenUtil().setWidth(30),
                                  //                 width:
                                  //                     ScreenUtil().setWidth(30),
                                  //                 decoration: new BoxDecoration(
                                  //                   color: primaryColor,
                                  //                   shape: BoxShape.circle,
                                  //                 ),
                                  //                 child: Text(
                                  //                   appGet.userMap['user']
                                  //                           ['name']
                                  //                       .toString()[0]
                                  //                       .toUpperCase(),
                                  //                   style: TextStyle(
                                  //                       color: Colors.white,
                                  //                       fontWeight:
                                  //                           FontWeight.bold),
                                  //                 ),
                                  //               ),
                                  //         new SizedBox(
                                  //           width: 10.0,
                                  //         ),
                                  //         Addcomments(
                                  //             appGet.posts[index]['id']),
                                  //         SizedBox(width: 10.w)
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
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
