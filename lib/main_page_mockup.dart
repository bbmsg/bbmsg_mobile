import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageMock extends StatelessWidget {
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              signOut();
            }),
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              print(appGet.userMap);
            }),
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              retrieveUser(token: appGet.token);
            })
      ],
    ));
  }
}
