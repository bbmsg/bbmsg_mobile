import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Editprofilescr extends StatefulWidget {
  Editprofilescr({Key key}) : super(key: key);

  @override
  _EditprofilescrState createState() => _EditprofilescrState();
}

class _EditprofilescrState extends State<Editprofilescr> {
  bool checkBoxValue = false;
  bool checkBoxValue2 = false;
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
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: HexColor('#200E32'),
              ),
            ),
            Text(
              'Edit Profile',
              style: TextStyle(
                  color: HexColor('#1A1818'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
            Text(
              'Save',
              style: TextStyle(
                  color: HexColor('#00ADEE'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait
                        ? ScreenUtil().setHeight(28)
                        : ScreenUtil().setHeight(28),
                    left: isPortrait
                        ? ScreenUtil().setWidth(137)
                        : ScreenUtil().setWidth(160)),
                child: Container(
                  width: isPortrait
                      ? ScreenUtil().setWidth(100.66)
                      : ScreenUtil().setWidth(50.99),
                  height: isPortrait
                      ? ScreenUtil().setHeight(100.66)
                      : ScreenUtil().setHeight(200.99),
                  decoration: BoxDecoration(
                      color: Colors.blue[300], shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/svgs/person.webp',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: isPortrait
                        ? ScreenUtil().setHeight(28)
                        : ScreenUtil().setHeight(28),
                    left: isPortrait
                        ? ScreenUtil().setWidth(137)
                        : ScreenUtil().setWidth(160)),
                child: Container(
                  width: isPortrait
                      ? ScreenUtil().setWidth(100.66)
                      : ScreenUtil().setWidth(50.99),
                  height: isPortrait
                      ? ScreenUtil().setHeight(100.66)
                      : ScreenUtil().setHeight(200.99),
                  decoration: BoxDecoration(
                      color: HexColor('#1A1818').withOpacity(.80),
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset(
                    'assets/pngs/camera.png',
                    // color: Colors.white,
                    width: isPortrait
                        ? ScreenUtil().setWidth(20)
                        : ScreenUtil().setWidth(20),
                    height: isPortrait
                        ? ScreenUtil().setHeight(20)
                        : ScreenUtil().setHeight(20),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: isPortrait
                ? ScreenUtil().setHeight(19)
                : ScreenUtil().setHeight(19),
          ),
          Container(
            width: isPortrait
                ? ScreenUtil().setWidth(375)
                : ScreenUtil().setWidth(375),
            height: isPortrait
                ? ScreenUtil().setHeight(1)
                : ScreenUtil().setHeight(1),
            decoration: BoxDecoration(color: HexColor('#CCCCCC')),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(21)
                    : ScreenUtil().setHeight(42),
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Text(
              'Name',
              style: TextStyle(
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(14)
                      : ScreenUtil().setSp(8),
                  color: HexColor('#1A1818')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Linda I. Hartz',
                    hintStyle: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(17)
                            : ScreenUtil().setSp(10),
                        color: HexColor('#00ADEE')),
                    border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(22)
                    : ScreenUtil().setHeight(44)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(375)
                  : ScreenUtil().setWidth(375),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
              decoration: BoxDecoration(color: HexColor('#CCCCCC')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(42),
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Text(
              'Address',
              style: TextStyle(
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(14)
                      : ScreenUtil().setSp(8),
                  color: HexColor('#1A1818')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Khalifa Park, Abu Dhabi, UAE',
                    hintStyle: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(17)
                            : ScreenUtil().setSp(10),
                        color: HexColor('#00ADEE')),
                    border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(40)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(375)
                  : ScreenUtil().setWidth(375),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
              decoration: BoxDecoration(color: HexColor('#CCCCCC')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(42),
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Text(
              'Email',
              style: TextStyle(
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(14)
                      : ScreenUtil().setSp(8),
                  color: HexColor('#1A1818')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Linda@host.com',
                    hintStyle: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(17)
                            : ScreenUtil().setSp(10),
                        color: HexColor('#00ADEE')),
                    border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(44)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(375)
                  : ScreenUtil().setWidth(375),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
              decoration: BoxDecoration(color: HexColor('#CCCCCC')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(42),
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Text(
              'Mobile',
              style: TextStyle(
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(14)
                      : ScreenUtil().setSp(8),
                  color: HexColor('#1A1818')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: '009715932145654',
                    hintStyle: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(17)
                            : ScreenUtil().setSp(10),
                        color: HexColor('#00ADEE')),
                    border: InputBorder.none),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(44)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(375)
                  : ScreenUtil().setWidth(375),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
              decoration: BoxDecoration(color: HexColor('#CCCCCC')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(42),
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Text(
              'Gender',
              style: TextStyle(
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(14)
                      : ScreenUtil().setSp(8),
                  color: HexColor('#1A1818')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isPortrait
                    ? ScreenUtil().setWidth(6)
                    : ScreenUtil().setWidth(12),
                top: isPortrait
                    ? ScreenUtil().setHeight(12)
                    : ScreenUtil().setHeight(12)),
            child: Row(
              children: [
                Checkbox(
                    value: checkBoxValue,
                    activeColor: HexColor('#00ADEE'),
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxValue = newValue;
                      });
                    }),
                Text(
                  'Male',
                  style: TextStyle(
                    fontSize: isPortrait
                        ? ScreenUtil().setSp(17)
                        : ScreenUtil().setSp(10),
                    // color: HexColor('#00ADEE')
                  ),
                ),
                SizedBox(
                  width: isPortrait
                      ? ScreenUtil().setWidth(27)
                      : ScreenUtil().setWidth(27),
                ),
                Checkbox(
                    value: checkBoxValue2,
                    activeColor: HexColor('#00ADEE'),
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxValue2 = newValue;
                      });
                    }),
                Text(
                  'Female',
                  style: TextStyle(
                      fontSize: isPortrait
                          ? ScreenUtil().setSp(17)
                          : ScreenUtil().setSp(10),
                      color: HexColor('#1A1818')),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(19)
                    : ScreenUtil().setHeight(44)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(375)
                  : ScreenUtil().setWidth(375),
              height: isPortrait
                  ? ScreenUtil().setHeight(1)
                  : ScreenUtil().setHeight(1),
              decoration: BoxDecoration(color: HexColor('#CCCCCC')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(23)
                    : ScreenUtil().setHeight(42),
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Text(
              'Birthdate',
              style: TextStyle(
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(14)
                      : ScreenUtil().setSp(8),
                  color: HexColor('#1A1818')),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: isPortrait
                    ? ScreenUtil().setWidth(19)
                    : ScreenUtil().setWidth(19)),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    hintText: '15-JAN-1990',
                    hintStyle: TextStyle(
                        fontSize: isPortrait
                            ? ScreenUtil().setSp(17)
                            : ScreenUtil().setSp(10),
                        color: HexColor('#00ADEE')),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
