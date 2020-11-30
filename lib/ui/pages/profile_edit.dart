import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProfileEdit extends StatelessWidget {
  AppGet appGet = Get.find();
  Map map;
  addValueToMap(String label, String value) {
    map[label] = value;
    Logger().d(map);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            alignment: Alignment.center,
            child: Text(
              'Save',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        title: new Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Container(
              child: SvgPicture.asset(
                'assets/svgs/camera.svg',
                height: 25.h,
              ),
              alignment: Alignment.center,
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                  color: Color(0xff000000),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      fit: BoxFit.contain,
                      image: appGet.userMap['user']['profile_picture'] != null
                          ? CachedNetworkImageProvider(
                              appGet.userMap['user']['profile_picture'])
                          : AssetImage('assets/pngs/logo.png'))),
            ),
            //////////////////////////////
            Divider(),
            EditableCustomText(
                'name', 'Name', appGet.userMap['user']['name'], addValueToMap),
            Divider(),
            EditableCustomText(
                'address',
                'Address',
                appGet.userMap['user']['address'] != null
                    ? appGet.userMap['user']['address']
                    : 'No Address',
                addValueToMap),
            Divider(),
            EditableCustomText(
                'email',
                'Email',
                appGet.userMap['user']['email'] != null
                    ? appGet.userMap['user']['email']
                    : 'No Email',
                addValueToMap),
            Divider(),
            EditableCustomText(
                'phone_number',
                'Name',
                appGet.userMap['user']['phone_number'] != null
                    ? appGet.userMap['user']['phone_number']
                    : 'No Mobile Number',
                addValueToMap),
            Divider(),
            EditableCustomText(
                'gender',
                'Gender',
                appGet.userMap['user']['gender'] != null
                    ? appGet.userMap['user']['gender']
                    : 'No Gender',
                addValueToMap),
            Divider(),
            EditableCustomText(
                'birthdate',
                'BirthDate',
                appGet.userMap['user']['birthdate'] != null
                    ? appGet.userMap['user']['birthdate']
                    : 'No Birthdate',
                addValueToMap),
//////////////////////////////////////
          ],
        ),
      ),
    );
  }
}

class EditableCustomText extends StatefulWidget {
  String label;
  String title;
  String value;
  Function fun;
  EditableCustomText(this.label, this.title, this.value, this.fun);

  @override
  _EditableTextState createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableCustomText> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isEditable = !isEditable;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            isEditable == false
                ? Text(widget.value,
                    style: TextStyle(color: primaryColor, fontSize: 17))
                : TextFormField(
                    style: TextStyle(color: primaryColor, fontSize: 17),
                    initialValue: widget.value,
                    onChanged: (String value) {
                      widget.value = value;
                      widget.fun(widget.label, value);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
