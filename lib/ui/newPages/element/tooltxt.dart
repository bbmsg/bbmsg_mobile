import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tooltxt extends StatefulWidget {
  final String txt;
  Tooltxt(this.txt, {Key key}) : super(key: key);

  @override
  _TooltxtState createState() => _TooltxtState();
}

class _TooltxtState extends State<Tooltxt> {
  bool colr = true;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return GestureDetector(
      onTap: () {
        setState(() {
          colr = !colr;
        });
      },
      child: Container(
        // height: ScreenUtil().setHeight(21),
        margin: EdgeInsets.only(left: 10),
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colr ? Colors.white : Colors.black,
            border: Border.all(width: 1)),
        child: Center(
            child: Text(
          widget.txt,
          style: TextStyle(
            color: colr ? Colors.black : Colors.white,
          ),
        )),
      ),
    );
  }
}
