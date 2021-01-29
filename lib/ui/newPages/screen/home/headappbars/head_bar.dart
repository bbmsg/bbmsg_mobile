import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Headbar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titles;
  final int ico;
  Function fun;
  Headbar(this.titles, this.ico, this.fun, {Key key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  _HeadbarState createState() => _HeadbarState();
}

class _HeadbarState extends State<Headbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/svgs/camera.svg',
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        onPressed: () {
          widget.fun();
        },
      ),
      title: SizedBox(
        height: 35.0,
        child: Text(
          widget.titles,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        // Image.asset("assets/images/insta_logo.png")
      ),
      actions: <Widget>[
        widget.ico != 3
            ? Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/send.svg',
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    widget.fun();
                    // getPosts();
                    // widget.fun();
                    // String token = SPHelper.spHelper.getToken();

                    // UserCredential userCredential = await signInWithTwitter();
                    // String token = await userCredential.user.getIdToken();

                    // checkUser();
                  },
                ),
              )
            : Container()
      ],
    );
  }
}
