import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/listpostcomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Commentbyid extends StatefulWidget {
  Commentbyid({Key key}) : super(key: key);

  @override
  _CommentbyidState createState() => _CommentbyidState();
}

class _CommentbyidState extends State<Commentbyid> {
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: 1,
      // appGet.commentpost != null ? appGet.commentpost['data'].length : 0,
      itemBuilder: (BuildContext context, int index) {
        print(appGet.commentpost['data'][index]['content'].toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              width: 300.h,
              height: 30,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      appGet.commentpost['data'][index]['author']['name']
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                      child: Text(
                    appGet.commentpost['data'][index]['content'].toString(),
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
            //
            GestureDetector(
              onTap: () {
                Get.to(Listcommentpost());
              },
              child: Flexible(
                child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      'View more',
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
            )
          ],
        );
      },
    );
  }
}
