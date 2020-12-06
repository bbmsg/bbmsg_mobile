import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Likes extends StatefulWidget {
  Likes({Key key}) : super(key: key);

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(18),
          right: ScreenUtil().setWidth(18),
          top: ScreenUtil().setHeight(20)),
      child: GridView.builder(
          itemCount: 9,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: ScreenUtil().setHeight(112),
              width: ScreenUtil().setWidth(112),
              child: Image.asset('assets/pngs/1.png'),
            );
          }),
    );
  }
}
