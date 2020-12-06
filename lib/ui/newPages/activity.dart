import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'activitycard.dart';

class Activityscr extends StatefulWidget {
  Activityscr({Key key}) : super(key: key);

  @override
  _ActivityscrState createState() => _ActivityscrState();
}

class _ActivityscrState extends State<Activityscr> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/images/camera.svg',
            ),
            Text(
              'Activity',
              style: TextStyle(
                  color: HexColor('#1A1818'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
            SvgPicture.asset('assets/images/send.svg')
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(8)
                    : ScreenUtil().setHeight(16),
                left: isPortrait
                    ? ScreenUtil().setWidth(18)
                    : ScreenUtil().setWidth(10)),
            child: Text(
              'Today',
              style: TextStyle(
                  color: HexColor('#161F3D'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(11)
                : ScreenUtil().setHeight(22),
          ),
          
          Activitycard(),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(28)
                    : ScreenUtil().setHeight(28),
                left: isPortrait
                    ? ScreenUtil().setWidth(18)
                    : ScreenUtil().setWidth(10)),
            child: Text(
              'Yesterday',
              style: TextStyle(
                  color: HexColor('#161F3D'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(11)
                : ScreenUtil().setHeight(22),
          ),
          Activitycard()
        ],
      ),
    );
  }
}
