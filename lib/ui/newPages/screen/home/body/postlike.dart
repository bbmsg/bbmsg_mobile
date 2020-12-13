import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:string_validator/string_validator.dart';

class Postlike extends StatefulWidget {
  final int id;

  Postlike(this.id, {Key key}) : super(key: key);

  @override
  _PostlikeState createState() => _PostlikeState();
}

class _PostlikeState extends State<Postlike> {
  bool isPressed = false;
  int totalsint = 0;
  int likeid = 0;
  @override
  void initState() {
    super.initState();
    print('postlike' + widget.id.toString());
    getLikes(widget.id).then((value) {
      if (value['total'] == 0) {
        isPressed = false;
      } else {
        isPressed = true;
      }
      setState(() {
        totalsint = value['total'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getLikes(widget.id);
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              new Row(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(isPressed == false
                        ? FontAwesomeIcons.heart
                        : Icons.favorite),
                    color: isPressed == false ? Colors.black : Colors.red,
                    onPressed: () {
                      setState(() {
                        isPressed = !isPressed;
                      });

                      isPressed ? like(widget.id) : removelike(widget.id);
                      isPressed
                          ? totalsint = totalsint + 1
                          : totalsint = totalsint - 1;
                    },
                  ),
                  Text(totalsint <= 0 ? '0' : totalsint.toString()),
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
                    '',
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Liked by" + ' ' + (totalsint>0?(totalsint - 1):0).toString() + ' other',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
