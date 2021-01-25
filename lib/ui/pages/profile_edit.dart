import 'dart:convert';
import 'dart:io';

import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  AppGet appGet = Get.find();

  Map map = {};

  addValueToMap(String label, dynamic value) {
    map[label] = value;
  }

  bool isNewImage = false;

  File file;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              updateUser('${appGet.userMap['user']['id']}', map);
              // // print(map);
              print('$map');
            },
            child: Container(
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
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
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
            GestureDetector(
              onTap: () async {
                PickedFile pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                file = File(pickedFile.path);

                dio.MultipartFile multipartFile =
                    await dio.MultipartFile.fromFile(file.path,
                        filename:
                            file.path.substring(file.path.lastIndexOf('/') + 1),
                        contentType: MediaType('image', 'jpeg'));

                map['profile_picture'] = multipartFile;

                setState(() {
                  isNewImage = true;
                });
              },
              child: Container(
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
                        fit: BoxFit.cover,
                        image: isNewImage == false
                            ? appGet.userMap['user']['profile_picture'] != null
                                ? CachedNetworkImageProvider(
                                    appGet.userMap['user']['profile_picture'])
                                : AssetImage('assets/pngs/back2.jpg')
                            : FileImage(file))),
              ),
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
                'Mobile',
                appGet.userMap['user']['phone_number'] != null
                    ? appGet.userMap['user']['phone_number']
                    : 'No Mobile Number',
                addValueToMap),
            Divider(),
            GenderDisplay(appGet.userMap['user']['gender'], addValueToMap),

            Divider(),
            BirthDate(
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

// class GenderDisplay extends StatefulWidget {
//   String genderValue;
//   Function fun;
//   GenderDisplay(this.genderValue, this.fun);

//   @override
//   _EditableTextState createState() => _EditableTextState();
// }

// class _GenderDisplay extends State<GenderDisplay> {
//   @override
//   Widget build(BuildContext context) {
//     return Text('ff');
//     // return Container(
//     //   padding: EdgeInsets.symmetric(vertical: 10.h),
//     //   child: Column(
//     //     crossAxisAlignment: CrossAxisAlignment.stretch,
//     //     children: [
//     //       // Text(
//     //       //   'Gender',
//     //       //   style: TextStyle(color: Colors.black, fontSize: 17),
//     //       // ),
//     //       // Row(
//     //       //   children: [
//     //       //     Expanded(
//     //       //       child: RadioListTile(
//     //       //           title: Text('Male'),
//     //       //           value: 'male',
//     //       //           groupValue: widget.genderValue,
//     //       //           onChanged: (String value) {
//     //       //             widget.genderValue = value;
//     //       //             widget.fun('gender', 'male');
//     //       //             setState(() {});
//     //       //           }),
//     //       //     ),
//     //       //     Expanded(
//     //       //       child: RadioListTile(
//     //       //           title: Text('Female'),
//     //       //           value: 'female',
//     //       //           groupValue: widget.genderValue,
//     //       //           onChanged: (String value) {
//     //       //             widget.genderValue = value;
//     //       //             widget.fun('gender', 'female');
//     //       //             setState(() {});
//     //       //           }),
//     //       //     )
//     //       //   ],
//     //       // )
//     //     ],
//     //   ),
//     // );
//   }
// }
class GenderDisplay extends StatefulWidget {
  String genderValue;
  Function fun;

  GenderDisplay(this.genderValue, this.fun);

  @override
  _GenderDisplayState createState() => _GenderDisplayState();
}

class _GenderDisplayState extends State<GenderDisplay> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Gender',
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        Row(
          children: [
            Row(
              children: [
                Text(
                  'Male',
                  style: TextStyle(
                      color: widget.genderValue != 'male'
                          ? Colors.black
                          : primaryColor,
                      fontSize: 17),
                ),
                Radio(
                    value: 'male',
                    groupValue: widget.genderValue,
                    onChanged: (value) {
                      this.widget.genderValue = value;
                      widget.fun('gender', value);
                      setState(() {});
                    }),
              ],
            ),
            SizedBox(
              width: 20.w,
            ),
            Row(
              children: [
                Text(
                  'FeMale',
                  style: TextStyle(
                      color: widget.genderValue != 'female'
                          ? Colors.black
                          : primaryColor,
                      fontSize: 17),
                ),
                Radio(
                    value: 'female',
                    groupValue: widget.genderValue,
                    onChanged: (value) {
                      this.widget.genderValue = value;
                      widget.fun('gender', value);
                      setState(() {});
                    }),
              ],
            )
          ],
        ),
      ],
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

class BirthDate extends StatefulWidget {
  String value;
  Function fun;
  BirthDate(this.value, this.fun);

  @override
  _BirthDateState createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(
              itemHeight: 50,
            ),
            showTitleActions: true,
            minTime: DateTime(1950, 1, 1),
            maxTime: DateTime.now(), onChanged: (date) {
          widget.value = '${date.day}-${date.month}-${date.year}';

          setState(() {});
          // addValueToMap('birthdate', date.);
        }, onConfirm: (date) {
          widget.value = '${date.day}-${date.month}-${date.year}';
          widget.fun('birthdate', date.toIso8601String());
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Birthdate',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.value,
                    style: TextStyle(color: primaryColor, fontSize: 17)),
                SvgPicture.asset(
                  'assets/svgs/calender.svg',
                  height: 17.h,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
