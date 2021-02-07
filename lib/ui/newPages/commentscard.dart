import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentsCard extends StatefulWidget {
  CommentsCard({Key key}) : super(key: key);

  @override
  _CommentsCardState createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Padding(
      padding: EdgeInsets.only(
        top: isPortrait
            ? ScreenUtil().setHeight(19)
            : ScreenUtil().setHeight(19),
        right:
            isPortrait ? ScreenUtil().setWidth(15) : ScreenUtil().setWidth(23),
        left:
            isPortrait ? ScreenUtil().setWidth(23) : ScreenUtil().setWidth(23),
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: isPortrait
                      ? ScreenUtil().setWidth(30)
                      : ScreenUtil().setWidth(20),
                  height: isPortrait
                      ? ScreenUtil().setHeight(30)
                      : ScreenUtil().setHeight(100),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/pngs/Avatar.png'
                            // snapshot.data['data'][index]
                            //         ['author']
                            //         ['profile_picture']
                            //     .toString(),
                            )),
                  ),
                ),
                // Container(
                //   width: isPortrait
                //       ? ScreenUtil().setWidth(30)
                //       : ScreenUtil().setWidth(20),
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(30)
                //       : ScreenUtil().setHeight(100),
                //   decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(100)),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(100),
                //     child: Image.asset('assets/pngs/Avatar.png'),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Antonia Berger',
                          style: TextStyle(
                              fontSize: isPortrait
                                  ? ScreenUtil().setSp(12)
                                  : ScreenUtil().setSp(8)),
                        ),
                        SizedBox(
                          width: isPortrait
                              ? ScreenUtil().setWidth(14)
                              : ScreenUtil().setWidth(30),
                        ),
                        Text(
                          '1 min',
                          style: TextStyle(
                              fontSize: isPortrait
                                  ? ScreenUtil().setSp(10)
                                  : ScreenUtil().setSp(6),
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: isPortrait
                          ? ScreenUtil().setHeight(6)
                          : ScreenUtil().setHeight(10),
                    ),
                    Row(
                      children: [
                        Container(
                          width: isPortrait
                              ? ScreenUtil().setWidth(230)
                              : ScreenUtil().setWidth(230),
                          child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '),
                        ),
                        SizedBox(
                          width: isPortrait
                              ? ScreenUtil().setWidth(10)
                              : ScreenUtil().setWidth(30),
                        ),
                        SvgPicture.asset('assets/svgs/ShareIcon.svg'),
                        SizedBox(
                          width: isPortrait
                              ? ScreenUtil().setWidth(0)
                              : ScreenUtil().setWidth(10),
                        ),
                        IconButton(
                          icon: new Icon(isPressed
                              ? Icons.favorite
                              : FontAwesomeIcons.heart),
                          color: isPressed ? Colors.red : Colors.black,
                          onPressed: () {
                            setState(() {
                              isPressed = !isPressed;
                            });
                          },
                        ),
                        // SvgPicture.asset('assets/svgs/Shape.svg')
                      ],
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(10)
                    : ScreenUtil().setHeight(10),
                left: isPortrait
                    ? ScreenUtil().setWidth(24)
                    : ScreenUtil().setWidth(24),
              ),
              child: Container(
                width: isPortrait
                    ? ScreenUtil().setWidth(351)
                    : ScreenUtil().setWidth(351),
                height: isPortrait
                    ? ScreenUtil().setHeight(1)
                    : ScreenUtil().setHeight(1),
                decoration: BoxDecoration(color: Colors.grey[200]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
