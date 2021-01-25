import 'dart:io';

import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/custom_image_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TestApi extends StatelessWidget {
  initState() {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text('hello world'),
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
