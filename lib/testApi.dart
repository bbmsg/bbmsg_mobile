import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: SvgPicture.asset(
            'assets/svgs/camera.svg',
            color: Colors.black,
            width: 20,
          ),
        ),
        body: Center(
          child: SvgPicture.asset(
            'assets/svgs/camera.svg',
            color: Colors.black,
            width: 30,
          ),
        ));
  }
}

class User {
  String imageUrl;
  String userName;
  String address;
  bool isFollow;
  User({this.address, this.imageUrl, this.userName, this.isFollow});
}
