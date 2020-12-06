import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/getimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Createpostscr extends StatefulWidget {
  Createpostscr({Key key}) : super(key: key);

  @override
  _CreatepostscrState createState() => _CreatepostscrState();
}

class _CreatepostscrState extends State<Createpostscr> {
  AppGet appget = Get.find();
  String dropdownValue = 'Public';

  TextEditingController contentController = new TextEditingController();
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
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: HexColor('#200E32'),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            Text(
              'Create Post',
              style: TextStyle(
                  color: HexColor('#1A1818'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
            GestureDetector(
              onTap: () {
                createPost(contentController.text, pickedImages);
              },
              child: Text(
                'Post',
                style: TextStyle(
                    color: HexColor('#00ADEE'),
                    fontSize: isPortrait
                        ? ScreenUtil().setSp(16)
                        : ScreenUtil().setSp(10)),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(8)
                    : ScreenUtil().setHeight(20),
                left: isPortrait
                    ? ScreenUtil().setWidth(18)
                    : ScreenUtil().setWidth(18)),
            child: Row(
              children: [
                Container(
                  width: isPortrait
                      ? ScreenUtil().setWidth(60)
                      : ScreenUtil().setWidth(40),
                  height: isPortrait
                      ? ScreenUtil().setHeight(60)
                      : ScreenUtil().setHeight(150),
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                      shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      appget.userMap['profile_picture'].toString(),
                      // 'assets/svgs/person.webp',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: isPortrait
                      ? ScreenUtil().setWidth(8)
                      : ScreenUtil().setWidth(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appget.userMap['name'].toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(16)
                              : ScreenUtil().setSp(10)),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? ScreenUtil().setHeight(10)
                          : ScreenUtil().setHeight(20),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: isPortrait
                            ? ScreenUtil().setWidth(73)
                            : ScreenUtil().setWidth(45),
                        height: isPortrait
                            ? ScreenUtil().setHeight(21)
                            : ScreenUtil().setHeight(42),
                        decoration: BoxDecoration(
                            border: Border.all(color: HexColor('#E1E1E1')),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: isPortrait
                                  ? ScreenUtil().setWidth(6)
                                  : ScreenUtil().setWidth(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset('assets/svgs/Shield Done.svg'),
                              SizedBox(
                                width: 55.w,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue,
                                  //   icon: Icon(Icons.arrow_downward),
                                  //  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>['Public', 'Private', 'Frind']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              // Text(
                              //   'Public',
                              //   style: TextStyle(
                              //       color: HexColor('#9B9B9B'),
                              //       fontSize: isPortrait
                              //           ? ScreenUtil().setSp(10)
                              //           : ScreenUtil().setSp(6)),
                              // ),
                              // Icon(Icons.keyboard_arrow_down,
                              //     color: HexColor('#9B9B9B')),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(20)
                    : ScreenUtil().setHeight(40),
                left: isPortrait
                    ? ScreenUtil().setWidth(10)
                    : ScreenUtil().setWidth(10),
                right: isPortrait
                    ? ScreenUtil().setWidth(10)
                    : ScreenUtil().setWidth(10)),
            child: Container(
              width: ScreenUtil().setWidth(326),
              height: ScreenUtil().setHeight(82),
              decoration: BoxDecoration(),
              child: TextField(
                controller: contentController,
                maxLines: 10,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    top: isPortrait
                        ? ScreenUtil().setHeight(15)
                        : ScreenUtil().setHeight(10),
                    left: isPortrait
                        ? ScreenUtil().setWidth(16)
                        : ScreenUtil().setWidth(10),
                  ),
                  hintText: 'What\'s in your mind?',
                  hintStyle: TextStyle(
                      fontSize: isPortrait
                          ? ScreenUtil().setSp(14)
                          : ScreenUtil().setSp(8),
                      color: HexColor('#606060')),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(321)
                : ScreenUtil().setHeight(321),
          ),
          GestureDetector(
            onTap: () {
              getimagdata(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: isPortrait
                      ? ScreenUtil().setWidth(26)
                      : ScreenUtil().setWidth(18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/image.svg'),
                  SizedBox(
                    width: isPortrait
                        ? ScreenUtil().setWidth(10)
                        : ScreenUtil().setWidth(10),
                  ),
                  Text(
                    'Photo/Video',
                    style: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(14)
                            : ScreenUtil().setSp(8),
                        color: HexColor('#3A3A3A')),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
              left: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
            ),
            child: Container(
              color: HexColor('#D4D4D4'),
              width: isPortrait
                  ? ScreenUtil().setWidth(353)
                  : ScreenUtil().setWidth(353),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(18),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                  left: isPortrait
                      ? ScreenUtil().setWidth(26)
                      : ScreenUtil().setWidth(18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/profile.svg'),
                  SizedBox(
                    width: isPortrait
                        ? ScreenUtil().setWidth(10)
                        : ScreenUtil().setWidth(10),
                  ),
                  Text(
                    'Tag Friends',
                    style: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(14)
                            : ScreenUtil().setSp(8),
                        color: HexColor('#3A3A3A')),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
              left: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
            ),
            child: Container(
              color: HexColor('#D4D4D4'),
              width: isPortrait
                  ? ScreenUtil().setWidth(353)
                  : ScreenUtil().setWidth(353),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(18),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                  left: isPortrait
                      ? ScreenUtil().setWidth(26)
                      : ScreenUtil().setWidth(18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/video.svg'),
                  SizedBox(
                    width: isPortrait
                        ? ScreenUtil().setWidth(10)
                        : ScreenUtil().setWidth(10),
                  ),
                  Text(
                    'Live Camera',
                    style: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(14)
                            : ScreenUtil().setSp(8),
                        color: HexColor('#3A3A3A')),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
              left: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
            ),
            child: Container(
              color: HexColor('#D4D4D4'),
              width: isPortrait
                  ? ScreenUtil().setWidth(353)
                  : ScreenUtil().setWidth(353),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(18),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                  left: isPortrait
                      ? ScreenUtil().setWidth(26)
                      : ScreenUtil().setWidth(18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/Location.svg'),
                  SizedBox(
                    width: isPortrait
                        ? ScreenUtil().setWidth(16)
                        : ScreenUtil().setWidth(14),
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(14)
                            : ScreenUtil().setSp(8),
                        color: HexColor('#3A3A3A')),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
              left: isPortrait
                  ? ScreenUtil().setWidth(22)
                  : ScreenUtil().setWidth(14),
            ),
            child: Container(
              color: HexColor('#D4D4D4'),
              width: isPortrait
                  ? ScreenUtil().setWidth(353)
                  : ScreenUtil().setWidth(353),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(18),
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                  left: isPortrait
                      ? ScreenUtil().setWidth(26)
                      : ScreenUtil().setWidth(18)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/smile.svg'),
                  SizedBox(
                    width: isPortrait
                        ? ScreenUtil().setWidth(16)
                        : ScreenUtil().setWidth(14),
                  ),
                  Text(
                    'Feeling',
                    style: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(14)
                            : ScreenUtil().setSp(8),
                        color: HexColor('#3A3A3A')),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(12)
                : ScreenUtil().setHeight(20),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     right: isPortrait
          //         ? ScreenUtil().setWidth(22)
          //         : ScreenUtil().setWidth(14),
          //     left: isPortrait
          //         ? ScreenUtil().setWidth(22)
          //         : ScreenUtil().setWidth(14),
          //   ),
          //   child: Container(
          //     color: HexColor('#D4D4D4'),
          //     width: isPortrait
          //         ? ScreenUtil().setWidth(353)
          //         : ScreenUtil().setWidth(353),
          //     height: isPortrait
          //         ? ScreenUtil().setHeight(1)
          //         : ScreenUtil().setHeight(1),
          //   ),
          // ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(23)
                : ScreenUtil().setHeight(23),
          ),
        ],
      ),
    );
  }
}
