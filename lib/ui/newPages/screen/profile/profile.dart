import 'package:bbmsg_mobile/ui/newPages/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Likes.dart';
import 'grid.dart';

class Profilescreen extends StatefulWidget {
  Profilescreen({Key key}) : super(key: key);

  @override
  _ProfilescreenState createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  int scrno = 1;
  getscreen(int scr) {
    if (scr == 1) {
      return ImageGrids();
    }
    if (scr == 2) {
      return Likes();
    }
  }

  @override
  void initState() {
    super.initState();
    getscreen(1);
  }

  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#FBFCFE'),
        body: ListView(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(49)),
          children: [
            Stack(
              children: [
                Container(
                    height: ScreenUtil().setHeight(289.63),
                    width: double.infinity,
                    child: Image.asset(
                      'assets/pngs/1.png',
                      fit: BoxFit.fill,
                      width: ScreenUtil().setWidth(375),
                      height: ScreenUtil().setHeight(289.63),
                    )),
                Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    left: 0,
                    child: Opacity(
                      opacity: 0.4,
                      child: new Container(
                        width: ScreenUtil().setWidth(375),
                        height: ScreenUtil().setHeight(289.63),
                        decoration: new BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                HexColor('#00ADEE'),
                                HexColor('#7850FF'),
                              ]),
                        ),
                      ),
                    )),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(28),
                        left: ScreenUtil().setWidth(18),
                        right: ScreenUtil().setWidth(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/settings.svg',
                            color: Colors.white,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontSize: isPortrait
                                    ? ScreenUtil().setSp(16)
                                    : ScreenUtil().setSp(10),
                                color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Editprofilescr());
                            },
                            child: SvgPicture.asset(
                              'assets/svgs/edit.svg',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(96.31),
                      height: ScreenUtil().setHeight(96.31),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/pngs/1.png',
                          )),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(13),
                    ),
                    Text(
                      'Linda I. Hartz',
                      style: TextStyle(
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(16)
                              : ScreenUtil().setSp(10),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(14),
                    ),
                    Text(
                      'New York',
                      style: TextStyle(
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(13)
                              : ScreenUtil().setSp(8),
                          color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(96.31),
              height: isPortrait
                  ? ScreenUtil().setHeight(130)
                  : ScreenUtil().setHeight(200),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(59),
                      right: ScreenUtil().setWidth(59),
                      top: ScreenUtil().setHeight(23),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '21',
                              style: TextStyle(
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(16)
                                      : ScreenUtil().setSp(10),
                                  color: HexColor('#00ADEE')),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(11)
                                      : ScreenUtil().setSp(7),
                                  color: HexColor('#161F3D')),
                            ),
                          ],
                        ),
                        Container(
                          width: ScreenUtil().setWidth(1),
                          height: ScreenUtil().setHeight(18.13),
                          color: HexColor('#D8D8D8'),
                        ),
                        Column(
                          children: [
                            Text(
                              '981',
                              style: TextStyle(
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(16)
                                      : ScreenUtil().setSp(10),
                                  color: HexColor('#00ADEE')),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(11)
                                      : ScreenUtil().setSp(7),
                                  color: HexColor('#161F3D')),
                            ),
                          ],
                        ),
                        Container(
                          width: ScreenUtil().setWidth(1),
                          height: ScreenUtil().setHeight(18.13),
                          color: HexColor('#D8D8D8'),
                        ),
                        Column(
                          children: [
                            Text(
                              '63',
                              style: TextStyle(
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(16)
                                      : ScreenUtil().setSp(10),
                                  color: HexColor('#00ADEE')),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  fontSize: isPortrait
                                      ? ScreenUtil().setSp(11)
                                      : ScreenUtil().setSp(7),
                                  color: HexColor('#161F3D')),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(31),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(39),
                      right: ScreenUtil().setWidth(39),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pressed = false;
                              scrno = 1;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Posts',
                                style: TextStyle(
                                    fontSize: isPortrait
                                        ? ScreenUtil().setSp(14)
                                        : ScreenUtil().setSp(9),
                                    color: pressed == true
                                        ? Colors.grey[400]
                                        : HexColor('#161F3D')),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(3),
                                width: ScreenUtil().setWidth(140),
                                decoration: BoxDecoration(
                                    color: pressed == true
                                        ? Colors.transparent
                                        : HexColor('#00ADEE'),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pressed = true;
                              scrno = 2;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Liked',
                                style: TextStyle(
                                    fontSize: isPortrait
                                        ? ScreenUtil().setSp(14)
                                        : ScreenUtil().setSp(9),
                                    color: pressed == false
                                        ? Colors.grey[400]
                                        : HexColor('#161F3D')),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(3),
                                width: ScreenUtil().setWidth(140),
                                decoration: BoxDecoration(
                                    color: pressed == false
                                        ? Colors.transparent
                                        : HexColor('#00ADEE'),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            getscreen(scrno)
          ],
        ),
      ),
    );
  }
}
