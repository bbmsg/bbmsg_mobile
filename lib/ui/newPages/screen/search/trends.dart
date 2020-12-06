import 'package:bbmsg_mobile/ui/newPages/element/tooltxt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Trendeslist extends StatefulWidget {
  Trendeslist({Key key}) : super(key: key);

  @override
  _TrendeslistState createState() => _TrendeslistState();
}

class _TrendeslistState extends State<Trendeslist> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return Container(
      height: ScreenUtil().setHeight(21),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Tooltxt('dd'),
          Tooltxt('dd'),
          Tooltxt('dd'),
          Tooltxt('dd'),
        ],
      ),
    );
  }
}
