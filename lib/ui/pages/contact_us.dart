import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/services/connectvity_service.dart';
import 'package:bbmsg_mobile/ui/widgets/TextField.dart';
import 'package:bbmsg_mobile/ui/widgets/primary_button.dart';
import 'package:bbmsg_mobile/utils/custom_dialoug.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'package:string_validator/string_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  GlobalKey<FormState> complainKey = GlobalKey();
  AppGet appGet = Get.find();
  String title;

  String content;

  saveTitle(String title) {
    this.title = title;
  }

  saveConent(String content) {
    this.content = content;
  }

  nullValidation(String value) {
    if (value.isEmpty) {
      return translator.translate('null_error');
    }
  }

  saveForm() async {
    if (complainKey.currentState.validate()) {
      complainKey.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        Future.delayed(Duration(seconds: 2)).then((value) {
          Get.back();
          Get.snackbar('success', 'Message has been sent');
        });
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error', titleKey: 'alert');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Form(
          key: complainKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.0.w),
                    borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  child: TextFormField(
                    maxLines: 2,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: translator.translate('title'),
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      return nullValidation(value);
                    },
                    onSaved: (newValue) => saveTitle(newValue),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize:
                          ScreenUtil().setSp(18, allowFontScalingSelf: true),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 300.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1.0.w),
                    borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                  ),
                  child: TextFormField(
                    maxLines: 15,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: translator.translate('content'),
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      return nullValidation(value);
                    },
                    onSaved: (newValue) => saveConent(newValue),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize:
                          ScreenUtil().setSp(18, allowFontScalingSelf: true),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: PrimaryButton(
                      textColor: Colors.white,
                      color: primaryColor,
                      textKey: 'add',
                      buttonPressFun: saveForm),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
