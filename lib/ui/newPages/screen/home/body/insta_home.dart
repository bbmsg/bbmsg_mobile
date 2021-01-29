import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/createpost.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/activity/activity.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/profile/profile.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/search/searchscr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: hiapp ? Headbar(titles, 1, createPost) : null,
        body: [
          InstaBody(createPost),
          Searchscr(),
          Createpostscr(),
          ActivityPage(),
          Profilescreen()
        ][currentIndex],
        bottomNavigationBar: new Container(
          color: Colors.white,
          height: 50.0,
          alignment: Alignment.center,
          child: new BottomAppBar(
            child: new Row(
              // alignment: MainAxisAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: currentIndex == 0
                      ? SvgPicture.asset(
                          'assets/svgs/FilledHome.svg',
                          // color: Colors.black,
                        )
                      : SvgPicture.asset(
                          'assets/svgs/Home.svg',
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                  // Icon(
                  //   // Icons.home,
                  // ),
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
                new IconButton(
                    icon: SvgPicture.asset(
                      'assets/svgs/Iconly-Light-Plus.svg',
                      color: Get.isDarkMode ? Colors.white : Colors.black,
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
                new IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/Group 4385.svg',
                    color: Get.isDarkMode ? Colors.white : Colors.black,
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
                new IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/Iconly-Light-Profile.svg',
                    // color: Colors.black,

                    color: Get.isDarkMode ? Colors.white : Colors.black,
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
