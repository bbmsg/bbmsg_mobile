import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Headbar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titles;
  final int ico;
  Function fun;
  bool isCreatePost;
  Headbar(this.titles, this.ico, this.fun, {this.isCreatePost = false})
      : preferredSize = Size.fromHeight(60.0);

  @override
  _HeadbarState createState() => _HeadbarState();
}

class _HeadbarState extends State<Headbar> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return AppBar(
      // backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      leading: widget.isCreatePost
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            )
          : IconButton(
              icon: SvgPicture.asset(
                'assets/svgs/camera.svg',
                color: _darkTheme ? Colors.white : Colors.black,
              ),
              onPressed: () {
                widget.fun();
              },
            ),
      title: SizedBox(
        height: 35.0,
        child: Text(
          widget.titles,
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
                    color: _darkTheme ? Colors.white : Colors.black,
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
