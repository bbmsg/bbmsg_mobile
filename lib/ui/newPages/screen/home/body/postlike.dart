import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Postlike extends StatefulWidget {
  final int id;
  final String like;
  final String comment;
  Postlike(this.id,this.like,this.comment,{Key key}) : super(key: key);

  @override
  _PostlikeState createState() => _PostlikeState();
}

class _PostlikeState extends State<Postlike> {
  bool isPressed = false;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                    isPressed ? Icons.favorite : FontAwesomeIcons.heart),
                color: isPressed ? Colors.red : Colors.black,
                onPressed: () {
                  like(widget.id);
                  setState(() {
                    isPressed = !isPressed;
                  });
                },
              ),
              new SizedBox(
                width: ScreenUtil().setWidth(12),
              ),
              Text(
               widget.like
              ),
              new SizedBox(
                width: ScreenUtil().setWidth(12),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/svgs/icomsg.svg',
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              new SizedBox(
                width: ScreenUtil().setWidth(12),
              ),
              Text(
               widget.comment,
              ),
            ],
          ),
          new IconButton(
            icon: SvgPicture.asset(
              'assets/svgs/return.svg',
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
