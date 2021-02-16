import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:bbmsg_mobile/ui/newPages/createpost.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/activity/activity.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/profile/profile.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/search/searchscr.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'insta_body.dart';

class InstaHome extends StatefulWidget {
  final int scrindex;
  InstaHome(this.scrindex, {Key key}) : super(key: key);
  @override
  _InstaHomeState createState() => _InstaHomeState();
}

class _InstaHomeState extends State<InstaHome> {
  String titles = '';
  @override
  void initState() {
    super.initState();
    titles = 'post';
    getcomments();

    currentIndex = widget.scrindex;
    if (widget.scrindex == 2) {
      hiapp = false;
    }
  }

  int currentIndex = 0;
  bool hiapp = true;
  createPost() {
    setState(() {
      currentIndex = 2;
      titles = 'Create post';
      hiapp = false;
    });
  }

  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return DefaultTabController(
      length: 5,
      child: new Scaffold(
          appBar: hiapp ? Headbar(titles, 1, createPost) : null,
          body: [
            InstaBody(createPost),
            Searchscr(),
            Createpostscr(false),
            ActivityPage(),
            Profilescreen()
          ][currentIndex],
          bottomNavigationBar: Obx(() {
            return Container(
              height: 70.h,
              alignment: Alignment.center,
              child: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: appGet.selectedItem == bottomItem.home
                          ? SvgPicture.asset(
                              'assets/svgs/home_filled.svg',
                              height: 30.h,
                              color: _darkTheme ? Colors.white : Colors.black,
                            )
                          : SvgPicture.asset(
                              'assets/svgs/home.svg',
                              height: 25.h,
                              color: _darkTheme ? Colors.white : Colors.black,
                            ),
                      onPressed: () {
                        setState(() {
                          appGet.selectedItem.value = bottomItem.home;
                          currentIndex = 0;
                          titles = 'posts';
                          hiapp = true;
                        });
                      },
                    ),
                    IconButton(
                        icon: SvgPicture.asset(
                          'assets/svgs/Iconly-Light-Plus.svg',
                          color: _darkTheme ? Colors.white : Colors.black,
                        ),
                        // Icon(
                        //   Icons.add_box,
                        // ),
                        onPressed: () {
                          setState(() {
                            appGet.selectedItem.value = bottomItem.create;
                            currentIndex = 2;
                            titles = 'Create post';
                            hiapp = false;
                          });
                        }),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/svgs/bell.svg',
                        color: _darkTheme ? Colors.white : Colors.black,
                      ),

                      // Icon(
                      //   Icons.favorite,
                      // ),
                      onPressed: () {
                        setState(() {
                          appGet.selectedItem.value = bottomItem.activity;
                          currentIndex = 3;
                          titles = 'Activity';
                          hiapp = true;
                          getActivity();
                        });
                      },
                    ),
                    appGet.userMap['user']['profile_picture'] != null
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 4;
                                titles = 'Profile';
                                hiapp = false;
                              });
                            },
                            child: Container(
                              height: ScreenUtil().setWidth(35),
                              width: ScreenUtil().setWidth(35),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(
                                      appGet.userMap['user']['profile_picture']
                                          .toString(),
                                    )),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 4;
                                titles = 'Profile';
                                hiapp = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().setWidth(30),
                              width: ScreenUtil().setWidth(30),
                              decoration: new BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                appGet.userMap['user']['name']
                                    .toString()[0]
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            );
          })),
    );
  }
}
