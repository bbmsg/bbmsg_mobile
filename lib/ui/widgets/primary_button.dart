import 'package:bbmsg_mobile/values/radii.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  Function buttonPressFun;
  String textKey;
  Color color;
  Color textColor;
  PrimaryButton(
      {this.buttonPressFun, this.textKey, this.color, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: RaisedButton(
          color: color,
          child: Text(
            translator.translate(textKey),
            style: TextStyle(color: textColor),
            maxLines: 1,
          ),
          shape: RoundedRectangleBorder(borderRadius: Radii.k8pxRadius),
          onPressed: () => buttonPressFun()),
    );
  }
}
