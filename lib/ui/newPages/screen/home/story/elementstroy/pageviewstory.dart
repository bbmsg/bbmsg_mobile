import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/elementstroy/photostoryshow.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Pageviewstory extends StatefulWidget {
  final List listall;
  final int pagini;
  Pageviewstory(this.listall, this.pagini, {Key key}) : super(key: key);

  @override
  _PageviewstoryState createState() => _PageviewstoryState();
}

class _PageviewstoryState extends State<Pageviewstory> {
  // int _currentPage = 0;
  // @override
  // initState() {
  //   super.initState();
  //   _currentPage = widget.pagini;
  // }

  AppGet appGet = Get.find();
  final pagcontroller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: appGet.pagcontroller,
        onPageChanged: (value) {
          logger.e('finished');
          if (appGet.completcycle == true.obs) {
            logger.e('finished');
            // _currentPage++;
            // pagcontroller.animateToPage(
            //   _currentPage,
            //   duration: Duration(milliseconds: 350),
            //   curve: Curves.easeIn,
            // );
          }
        },
        children: [
          for (var i = 0; i < widget.listall.length; i++)
            Stack(
              children: [
                PhotoStoryshow('tt', widget.listall[i]['stories'],
                    widget.listall[i]['author']),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 60.h,
                    horizontal: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.listall[i]['author']['profile_picture'] != null
                              ? Container(
                                  height: ScreenUtil().setWidth(35),
                                  width: ScreenUtil().setWidth(35),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: CachedNetworkImageProvider(
                                          widget.listall[i]['author']
                                                  ['profile_picture']
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
                                    widget.listall[i]['author']['name']
                                        .toString()[0]
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            widget.listall[i]['author']['name'],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(150),
                            child: new Text(
                              // "10 min",
                              readTimestamp(DateTime.parse(widget.listall[i]
                                  ['stories'][i]['created_at'])),
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          widget.listall[i]['author']['id'] ==
                                  appGet.userMap['user']['id']
                              ? GestureDetector(
                                  onTapDown: (TapDownDetails details) async {
                                    double left = details.globalPosition.dx;
                                    double top = details.globalPosition.dy;
                                    var x = await showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          left, top, 0, 0),
                                      items: [
                                        PopupMenuItem<String>(
                                            child: const Text('Delete post'),
                                            value: 'delete'),
                                      ],
                                      elevation: 8.0,
                                    );
                                    if (x == 'delete') {
                                      deleteStories(
                                          widget.listall[i]['stories'][i]['id'],
                                          i);
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
                                      position: RelativeRect.fromLTRB(
                                          left, top, 0, 0),
                                      items: [
                                        PopupMenuItem<String>(
                                            child: const Text('Block'),
                                            value: 'block'),
                                        PopupMenuItem<String>(
                                            child: const Text('Report post'),
                                            value: 'report'),
                                      ],
                                      elevation: 8.0,
                                    );
                                    if (x == 'block') {
                                      blockUser(
                                          widget.listall[i]['author']['id']);
                                    } else if (x == 'report') {
                                      reportPost(
                                          widget.listall[i]['stories'][i]['id'],
                                          i);
                                    }
                                  },
                                  child: Icon(Icons.more_horiz),
                                ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
