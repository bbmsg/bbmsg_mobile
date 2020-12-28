import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Headbar extends StatefulWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titles;
  final int ico;
  Headbar(this.titles, this.ico, {Key key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  _HeadbarState createState() => _HeadbarState();
}

class _HeadbarState extends State<Headbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          widget.ico != 1 ? Icons.arrow_back_ios : Icons.camera_alt_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context, 'Yep!');
        },
      ),
      title: SizedBox(
        height: 35.0,
        child: Text(
          widget.titles,
          style: TextStyle(color: Colors.black),
        ),
        // Image.asset("assets/images/insta_logo.png")
      ),
      actions: <Widget>[
        widget.ico != 3
            ? Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: IconButton(
                  icon: SvgPicture.asset('assets/svgs/send.svg'),
                  onPressed: () {
                    DateTime data = DateTime.parse('2020-12-28T13:31:44.453Z');
                    logger.e(DateFormat.yMd().format(data));
                    logger.e(DateFormat.yMMMEd().format(data));
                    logger.e(DateFormat.yMMMM().format(data));
                    logger.e(DateFormat.yMMMMEEEEd().format(data));
                    logger.e(DateFormat.yMMMMd().format(data));
                    logger.e(DateFormat.yMMMd().format(data));
                    logger.e(DateFormat.Md().format(data));

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
