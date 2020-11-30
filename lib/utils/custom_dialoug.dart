import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

class CustomDialougs {
  CustomDialougs._();
  AppGet appGet = Get.put(AppGet());
  static CustomDialougs utils = CustomDialougs._();
  Function du = () => Get.back();
  showDialoug({String titleKey, String messageKey, Function fun}) {
    appGet.pr.hide();
    Get.defaultDialog(
        confirm: CupertinoButton(
            child: Text('Ok'),
            onPressed: fun != null ? () => fun() : () => du()),
        middleText: translator.translate(messageKey),
        title: translator.translate(titleKey));
  }

  showSackbar({String titleKey, String messageKey}) {
    Get.snackbar(
      translator.translate(titleKey),
      translator.translate(messageKey),
      duration: Duration(seconds: 3),
    );
  }
}
