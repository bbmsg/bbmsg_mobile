import 'package:auto_size_text/auto_size_text.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/widgets/follow_user_widget.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlockScreen extends StatelessWidget {
  AppGet appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Block Area',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10.h),
        child:
            // Center(
            //   child: RaisedButton(onPressed: () {
            //     print(appGet.following);
            //   }),
            // )

            Obx(() {
          return appGet.following['data'] != null
              ? ListView.builder(
                  itemCount: appGet.blockMap['total'],
                  itemBuilder: (context, index) {
                    return BlockWidget(appGet.blockMap['data'][index]);
                  },
                )
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}

class BlockWidget extends StatefulWidget {
  Map map;
  BlockWidget(this.map);

  @override
  _FollowingWidgetState createState() => _FollowingWidgetState();
}

class _FollowingWidgetState extends State<BlockWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
        height: 75.h,
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: widget.map['blocked_user']['profile_picture'] != null
                  ? Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.w),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(widget
                                  .map['blocked_user']['profile_picture']),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      alignment: Alignment.center,
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5.w),
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: Text(
                        widget.map['blocked_user']['name'][0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 6,
              child: AutoSizeText(
                widget.map['blocked_user']['name'],
                style: TextStyle(color: Colors.black, fontSize: 15),
                maxLines: 1,
              ),
            ),
            Expanded(
              flex: 3,
              child: RaisedButton(
                  elevation: 0,
                  child: AutoSizeText(
                    'UnBlock',
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    unBlockUser(widget.map['id']);
                  }),
            )
          ],
        ));
  }
}
