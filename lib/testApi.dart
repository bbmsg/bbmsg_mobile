import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services%20copy/shared_prefrences_helper.dart';
import 'package:flutter/material.dart';

class TestApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(
      child: RaisedButton(onPressed: () async {
        GetFollowing(true);
      }),
    ));
  }
}
