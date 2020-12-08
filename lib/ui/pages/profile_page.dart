import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  AppGet appGet = Get.find();
  String name;
  ProfilePage(this.name);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        title: new Text(
          "$name Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          alignment: Alignment.center,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: appGet.otherUserMap['profile_picture'] != null
                            ? CachedNetworkImageProvider(
                                appGet.otherUserMap['profile_picture'])
                            : AssetImage('assets/pngs/logo.png'))),
              ),
              //////////////////////////////
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
                height: 50.h,
                width: 800.w,
                child: RaisedButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      followUser(appGet.otherUserMap['id'].toString());
                    }),
              ),
              Divider(),
              EditableCustomText(
                  'Name', appGet.otherUserMap['name'] ?? 'Not Defined'),

              Divider(),
              EditableCustomText(
                  'Address', appGet.otherUserMap['address'] ?? 'Not Defined'),
              Divider(),
              EditableCustomText(
                  'Email', appGet.otherUserMap['email'] ?? 'Not Defined'),
              Divider(),
              EditableCustomText('Mobile',
                  appGet.otherUserMap['phone_number'] ?? 'Not Defined'),
              Divider(),
              EditableCustomText(
                  'Gender', appGet.otherUserMap['gender'] ?? 'Not Defined'),
              Divider(),
              EditableCustomText('BirthDate',
                  appGet.otherUserMap['birthdate'] ?? 'Not Defined'),

//////////////////////////////////////
            ],
          ),
        );
      }),
    );
  }
}

class EditableCustomText extends StatefulWidget {
  String title;
  String value;

  EditableCustomText(this.title, this.value);

  @override
  _EditableTextState createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableCustomText> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          Text(widget.value,
              style: TextStyle(color: primaryColor, fontSize: 17))
        ],
      ),
    );
  }
}
