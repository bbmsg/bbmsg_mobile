import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'editprofile.dart';

class Activitycard extends StatefulWidget {
  Activitycard({Key key}) : super(key: key);

  @override
  _ActivitycardState createState() => _ActivitycardState();
}

class _ActivitycardState extends State<Activitycard> {
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Padding(
      padding: EdgeInsets.only(
          left: isPortrait
              ? ScreenUtil().setWidth(20)
              : ScreenUtil().setWidth(20),
          right: isPortrait
              ? ScreenUtil().setWidth(24)
              : ScreenUtil().setWidth(24)),
      child: Container(
        width: isPortrait
            ? ScreenUtil().setWidth(325)
            : ScreenUtil().setWidth(325),
        height: isPortrait
            ? ScreenUtil().setHeight(140)
            : ScreenUtil().setHeight(250),
        // color: Colors.amber,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: isPortrait
                      ? ScreenUtil().setWidth(48)
                      : ScreenUtil().setWidth(30),
                  height: isPortrait
                      ? ScreenUtil().setHeight(48)
                      : ScreenUtil().setHeight(120),
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/svgs/person.webp',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: isPortrait
                      ? ScreenUtil().setWidth(15)
                      : ScreenUtil().setWidth(30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Alex Edward Martinez',
                          style: TextStyle(
                              fontSize: isPortrait
                                  ? ScreenUtil().setSp(16)
                                  : ScreenUtil().setSp(10),
                              color: HexColor('#161F3D')),
                        ),
                        SizedBox(
                          width: isPortrait
                              ? ScreenUtil().setWidth(60)
                              : ScreenUtil().setWidth(150),
                        ),
                        Text(
                          '09:24 PM',
                          style: TextStyle(
                              fontSize: isPortrait
                                  ? ScreenUtil().setSp(11)
                                  : ScreenUtil().setSp(5),
                              color: Colors.grey[400]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isPortrait
                          ? ScreenUtil().setHeight(3)
                          : ScreenUtil().setHeight(10),
                    ),
                    Text(
                      'Commented on your post',
                      style: TextStyle(
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(10)
                              : ScreenUtil().setSp(5),
                          color: Colors.grey[400]),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? ScreenUtil().setHeight(11)
                          : ScreenUtil().setHeight(18),
                    ),
                    Text(
                      '“I am interested in taking you property on \nrent. Contact me',
                      style: TextStyle(
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(14)
                              : ScreenUtil().setSp(8),
                          color: HexColor('#161F3D')),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(Editprofilescr());
                          },
                          child: Container(
                            width: isPortrait
                                ? ScreenUtil().setWidth(52)
                                : ScreenUtil().setWidth(30),
                            height: isPortrait
                                ? ScreenUtil().setHeight(23)
                                : ScreenUtil().setHeight(60),
                            decoration: BoxDecoration(
                                color: HexColor('#00ADEE'),
                                borderRadius: BorderRadius.circular(28)),
                            child: Center(
                                child: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(10)
                                      : ScreenUtil().setSp(5)),
                            )),
                          ),
                        ),
                        SizedBox(
                          width: isPortrait
                              ? ScreenUtil().setWidth(8)
                              : ScreenUtil().setWidth(16),
                        ),
                        Container(
                          width: isPortrait
                              ? ScreenUtil().setWidth(52)
                              : ScreenUtil().setWidth(30),
                          height: isPortrait
                              ? ScreenUtil().setHeight(23)
                              : ScreenUtil().setHeight(60),
                          decoration: BoxDecoration(
                              // color: HexColor('#00ADEE'),
                              border: Border.all(color: HexColor('#00ADEE')),
                              borderRadius: BorderRadius.circular(28)),
                          child: Center(
                              child: Text(
                            'Ignore',
                            style: TextStyle(
                                color: HexColor('#00ADEE'),
                                fontSize: isPortrait
                                    ? ScreenUtil().setSp(10)
                                    : ScreenUtil().setSp(5)),
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: isPortrait
                  ? ScreenUtil().setHeight(13)
                  : ScreenUtil().setHeight(13),
            ),
            Container(
              color: Colors.grey[400],
              width: isPortrait
                  ? ScreenUtil().setWidth(321)
                  : ScreenUtil().setWidth(321),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
            )
          ],
        ),
      ),
    );
  }
}
