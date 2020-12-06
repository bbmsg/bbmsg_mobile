import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Listcommentpost extends StatefulWidget {
  Listcommentpost({Key key}) : super(key: key);

  @override
  _ListcommentpostState createState() => _ListcommentpostState();
}

class _ListcommentpostState extends State<Listcommentpost> {
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Comment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new ListView.builder(
        shrinkWrap: true,
        itemCount:
            appGet.commentpost != null ? appGet.commentpost['data'].length : 0,
        itemBuilder: (BuildContext context, int index) {
          print(appGet.commentpost['data'][index]['content'].toString());
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: 420.w,
                height: 30.h,
                child: Row(
                  children: [
                    Container(
                      height: ScreenUtil().setWidth(40),
                      width: ScreenUtil().setWidth(40),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                              appGet.commentpost['data'][index]['author']
                                      ['profile_picture']
                                  .toString(),
                            )),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        appGet.commentpost['data'][index]['author']['name']
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                        child: Container(
                      padding:
                          EdgeInsets.only(top: 10.h, right: 10.w, left: 10.w),
                      child: Text(
                        appGet.commentpost['data'][index]['content'].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )),
                  ],
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120.w,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                    Container(
                      width: 80.w,
                      height: 30.h,
                      // color: Colors.grey,
                      child: Center(child: Text('View reply')),
                    ),
                    Container(
                      width: 120.w,
                      height: 1.5,
                      color: Colors.grey,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
