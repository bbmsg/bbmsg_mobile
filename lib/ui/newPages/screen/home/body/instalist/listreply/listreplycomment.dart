import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Listrplaycomment extends StatefulWidget {
  final int rplyidcomment;
  Listrplaycomment(this.rplyidcomment, {Key key}) : super(key: key);

  @override
  _ListrplaycommentState createState() => _ListrplaycommentState();
}

class _ListrplaycommentState extends State<Listrplaycomment> {
  AppGet appGet = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40.w),
      height: 40.h,
      child: FutureBuilder(
        future: getAreplay(widget.rplyidcomment),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 40.w),
                      height: 30.h,
                      width: 220.w,
                      color: Colors.red,
                      child: Text(snapshot.data[index]['content'].toString()),
                    );
                  },
                )
              : CircularProgressIndicator();
        },
      ),
    );
  }
}
