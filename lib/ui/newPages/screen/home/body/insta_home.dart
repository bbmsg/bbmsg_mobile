import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/createpost.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/profile/profile.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/search/searchscr.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'insta_body.dart';

class InstaHome extends StatefulWidget {
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
  }
  // final topBar = new AppBar(
  //   backgroundColor: new Color(0xfff8faf8),
  //   centerTitle: true,
  //   elevation: 1.0,
  //   leading: new Icon(Icons.camera_alt_outlined),
  //   title: SizedBox(
  //       height: 35.0, child:
  //       // Text(titles),
  //       Image.asset("assets/images/insta_logo.png")
  //       ),
  //   actions: <Widget>[
  //     Padding(
  //       padding: const EdgeInsets.only(right: 12.0),
  //       child: Icon(FontAwesomeIcons.paperPlane),
  //     )
  //   ],
  // );

  int currentIndex = 0;
  bool hiapp = true;
  var _pages = [InstaBody(), Searchscr(), Createpostscr(), ProfilePage(), Profilescreen()];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return new Scaffold(
        appBar: hiapp
            ? AppBar(
                backgroundColor: new Color(0xfff8faf8),
                centerTitle: true,
                elevation: 0.0,
                leading: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
                title: SizedBox(
                  height: 35.0,
                  child: Text(
                    titles,
                    style: TextStyle(color: Colors.black),
                  ),
                  // Image.asset("assets/images/insta_logo.png")
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      icon: SvgPicture.asset('assets/svgs/send.svg'),
                      onPressed: null,
                    ),
                  )
                ],
              )
            : null,
        body: _pages[currentIndex],
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
                      ? SvgPicture.asset('assets/svgs/FilledHome.svg')
                      : SvgPicture.asset('assets/svgs/Home.svg'),
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
                new IconButton(
                  icon: currentIndex == 1
                      ? SvgPicture.asset('assets/svgs/SearchFilled.svg')
                      : SvgPicture.asset('assets/svgs/Group 4384.svg'),
                  // Icon(
                  //   Icons.search,
                  // ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                      titles = 'Search';
                      hiapp = true;
                    });
                  },
                ),
                new IconButton(
                    icon: SvgPicture.asset('assets/svgs/Iconly-Light-Plus.svg'),
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
                  icon: SvgPicture.asset('assets/svgs/Group 4385.svg'),

                  // Icon(
                  //   Icons.favorite,
                  // ),
                  onPressed: null,
                ),
                new IconButton(
                  icon:
                      SvgPicture.asset('assets/svgs/Iconly-Light-Profile.svg'),

                  // Icon(
                  //   Icons.account_box,
                  // ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                      titles = 'Profile';
                      hiapp = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
