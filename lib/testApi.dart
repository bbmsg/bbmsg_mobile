import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';

class TestApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(
      child: RaisedButton(onPressed: () async {
        getActivity();
      }),
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
