import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ProgressDialogUtils {
  static ArsProgressDialog pr = ArsProgressDialog(Get.context,
      blur: 2,
      backgroundColor: Color(0x33000000),
      loadingWidget: Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(
            radius: 20,
          ),
        ),
      ));
}
