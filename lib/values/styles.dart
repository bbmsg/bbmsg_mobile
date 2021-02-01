import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Styles {
  static TextStyle titleTextStyle = TextStyle(
      fontFamily: 'header_font',
      color: primaryColor,
      fontWeight: FontWeight.w700,
      fontSize: 20);
  static TextStyle secondTitleTextStyle =
      TextStyle(fontFamily: 'second_header', fontSize: 15);

  static TextStyle subTitleTextStyle =
      TextStyle(fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true));
  static TextStyle hyperlinkText = TextStyle(
      fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
      color: primaryColor);
  static TextStyle appBarTitle = TextStyle(color: Colors.white);
  static TextStyle profileText = TextStyle(
      fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
      color: Colors.black);
  static TextStyle profileValuesText = TextStyle(
      fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
      color: Color(0xff707070));

  static TextStyle headerStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: ScreenUtil().setSp(25, allowFontScalingSelf: true),
      color: Color(0xff707070));
}
