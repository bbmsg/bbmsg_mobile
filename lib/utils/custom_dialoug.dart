import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/utils/ProgressDialogUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:popup_menu/popup_menu.dart';

class CustomDialougs {
  CustomDialougs._();
  AppGet appGet = Get.put(AppGet());
  static CustomDialougs utils = CustomDialougs._();
  Function du = () => Get.back();
  showDialoug({String titleKey, String messageKey, Function fun}) {
    ProgressDialogUtils.pr.dismiss();
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

  PopupMenu createMenu(int userId) {
    PopupMenu menu = PopupMenu(
      items: [
        MenuItem(title: 'Block', image: Image.asset('assets/pngs/block.png')),
      ],
      onClickMenu: (item) {
        logger.e(item.menuTitle == 'Block');
      },
      onDismiss: () {},
    );
    return menu;
  }
}
