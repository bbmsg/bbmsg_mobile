import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:bbmsg_mobile/ui/newPages/createpost.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/activity/activity.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/profile/profile.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/search/searchscr.dart';
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
    return new Scaffold(
        appBar: hiapp ? Headbar(titles, 1, createPost) : null,
        body: [
          InstaBody(createPost),
          Searchscr(),
          Createpostscr(false),
          ActivityPage(),
          Profilescreen()
        ][currentIndex],
        bottomNavigationBar: new Container(
          height: Get.isDarkMode ? 80.h : 80.h,
          alignment: Alignment.center,
          child: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: currentIndex == 0
                      ? SvgPicture.asset(
                          'assets/svgs/FilledHome.svg',
                          color: _darkTheme ? Colors.white : Colors.black,
                        )
                      : SvgPicture.asset(
                          'assets/svgs/Home.svg',
                          color: _darkTheme ? Colors.white : Colors.black,
                        ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 0;
                      titles = 'posts';
                      hiapp = true;
                    });
                  },
                ),
                // new IconButton(
                //   icon: currentIndex == 1
                //       ? SvgPicture.asset('assets/svgs/SearchFilled.svg',
                //           color: Colors.black)
                //       : SvgPicture.asset('assets/svgs/Group 4384.svg',
                //           color: Colors.black),
                //   // Icon(
                //   //   Icons.search,
                //   // ),
                //   onPressed: () {
                //     setState(() {
                //       currentIndex = 1;
                //       titles = 'Search';
                //       hiapp = true;
                //     });
                //   },
                // ),
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
                        currentIndex = 2;
                        titles = 'Create post';
                        hiapp = false;
                      });
                    }),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/Group 4385.svg',
                    color: _darkTheme ? Colors.white : Colors.black,
                  ),

                  // Icon(
                  //   Icons.favorite,
                  // ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                      titles = 'Activity';
                      hiapp = true;
                      getActivity();
                    });
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/Iconly-Light-Profile.svg',
                    // color: Colors.black,

                    color: _darkTheme ? Colors.white : Colors.black,
                  ),

                  // Icon(
                  //   Icons.account_box,
                  // ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                      titles = 'Profile';
                      hiapp = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
