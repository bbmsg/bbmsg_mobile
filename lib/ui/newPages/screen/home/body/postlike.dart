import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Postlike extends StatefulWidget {
  final int id;
  final String like;
  final String comment;
  Postlike(this.id, this.like, this.comment, {Key key}) : super(key: key);

  @override
  _PostlikeState createState() => _PostlikeState();
}

class _PostlikeState extends State<Postlike> {
  int isPressed = 0;
  int totalsint;
  int likeid;
  @override
  void initState() {
    super.initState();
    getLikes(widget.id).then((value) {
      if (value['data'].length == 0) {
        isPressed = 0;
      } else {
        isPressed = 1;
        likeid = value['data'][0]['id'];
      }
      totalsint = value['total'];
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                    isPressed == 0 ? FontAwesomeIcons.heart : Icons.favorite),
                color: isPressed == 0 ? Colors.black : Colors.red,
                onPressed: () {
                  if (isPressed == 0) {
                    print(isPressed);
                    setState(() {
                      isPressed = 1;
                    });
                    totalsint = totalsint + 1;
                    like(widget.id).then((value) {
                      getLikes(widget.id).then((ee) {
                        print('long' + widget.id.toString());
                        if (ee['data'].length == 0) {
                          isPressed = 0;
                        } else {
                          isPressed = 1;
                          likeid = ee['data'][0]['id'];
                        }
                        totalsint = ee['total'];
                        print('totadd' + totalsint.toString());
                      });
                    });
                    setState(() {
                      // totalsint;
                    });
                  } else {
                    print(isPressed);
                    setState(() {
                      isPressed = 0;
                    });

                    totalsint = totalsint - 1;
                    removelike(likeid).then((value) {
                      getLikes(widget.id).then((ee) {
                        print('long' + widget.id.toString());
                        if (ee['data'].length == 0) {
                          isPressed = 0;
                        } else {
                          isPressed = 1;
                          likeid = ee['data'][0]['id'];
                        }
                        totalsint = ee['total'];
                        print('totmin' + totalsint.toString());
                      });
                    });

                    setState(() {
                      // totalsint;
                    });
                  }
                },
              ),
              Text(totalsint == null ? '0' : totalsint.toString()),
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
