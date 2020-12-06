import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class Postnew extends StatefulWidget {
  Postnew({Key key}) : super(key: key);

  @override
  _PostnewState createState() => _PostnewState();
}

class _PostnewState extends State<Postnew> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);

    return Row(
      children: [
        Container(
          width: ScreenUtil().setWidth(60),
          height: ScreenUtil().setHeight(60),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new NetworkImage(
                    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
          ),
        ),
        Flexible(
          child: Column(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(270),
                height: ScreenUtil().setHeight(29),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Antonia Berger',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(270),
                height: ScreenUtil().setHeight(29),
                child: Padding(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Center(
                        child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                              width: .5, color: Colors.white)),
                      child: TextField(
                        textAlign: TextAlign.left,
                        // controller: searchCtrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Whats in your mind?',
                          hintStyle: TextStyle(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(color: HexColor('#B8B7B7'))
                            //   borderSide: BorderSide(
                            // //     // color: Colors.grey[200],
                            //     width: 0,
                            //     style: BorderStyle.none,
                            //   ),
                          ),
                          // filled: true,
                          contentPadding: EdgeInsets.only(top: 0, left: 10, right: 10),
                          // fillColor: Colors.grey[200],
                        ),
                      ),
                    ))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
