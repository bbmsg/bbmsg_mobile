import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/ui/widgets/follow_user_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:string_validator/string_validator.dart';

class TestApi extends StatelessWidget {
  List<User> users = [
    User(
        isFollow: true,
        address: 'Gaza',
        userName: 'Shady',
        imageUrl:
            'https://manofmany.com/wp-content/uploads/2019/06/50-Long-Haircuts-Hairstyle-Tips-for-Men-2.jpg'),
    User(
        isFollow: false,
        address: 'Jabalia',
        userName: 'Jaber',
        imageUrl:
            'https://miro.medium.com/max/11520/1*MKkufG0eyT0IQ5wZ70qKxQ.jpeg'),
    User(
        isFollow: false,
        address: 'Alnusairat',
        userName: 'Zaid',
        imageUrl:
            'https://i.pinimg.com/originals/f0/a6/4e/f0a64e32194d341befecc80458707565.jpg'),
    User(
        isFollow: true,
        address: 'alzahra',
        userName: 'Jabal',
        imageUrl:
            'https://wwwimage-secure.cbsstatic.com/thumbnails/photos/w1920-q80/marquee/11/77/27/6/hero_landscape_91e1b039-11ef-4d97-a01e-639b6ee4990a.jpg'),
    User(
        isFollow: false,
        address: 'Egypt',
        userName: 'Waleed',
        imageUrl:
            'https://www.mantruckandbus.com/fileadmin/media/bilder/02_19/219_05_busbusiness_interviewHeader_1485x1254.jpg')
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(
      child: RaisedButton(onPressed: () async {
        // String token = SPHelper.spHelper.getToken();
        print(appGet.userMap);
        // UserCredential userCredential = await signInWithTwitter();
        // String token = await userCredential.user.getIdToken();

        // checkUser();
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
