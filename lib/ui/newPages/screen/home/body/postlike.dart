import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PostLikeAndCommentWidget extends StatelessWidget {
  int index;
  PostLikeAndCommentWidget(this.index);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<AppGet>(
        init: AppGet(), // INIT IT ONLY THE FIRST TIME
        builder: (x) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    new Row(
                      children: <Widget>[
                        new IconButton(
                          icon: x.posts[index]['my_like'] == 0
                              ? SvgPicture.asset('assets/svgs/heart.svg')
                              : SvgPicture.asset('assets/svgs/Shape.svg'),
                          color: Colors.red,
                          onPressed: () {
                            x.posts[index]['my_like'] == 0
                                ? like(x.posts[index]['id'], index)
                                : removelike(x.posts[index]['my_like'], index);
                          },
                        ),
                        Text(x.posts[index]['likes'].toString()),
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
                          appGet.posts[index]['comments'].toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
