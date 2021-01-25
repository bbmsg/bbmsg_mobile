import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGrids extends StatefulWidget {
  ImageGrids({Key key}) : super(key: key);

  @override
  _ImageGridsState createState() => _ImageGridsState();
}

class _ImageGridsState extends State<ImageGrids> {
  @override
  Widget build(BuildContext context) {
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
