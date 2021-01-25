import 'package:auto_size_text/auto_size_text.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class FollowUserWidget extends StatefulWidget {
  String imageUrl;
  String userName;
  String address;
  Function fun;
  bool isFollow;
  String id;
  FollowUserWidget(
      {this.imageUrl,
      this.address,
      this.userName,
      this.fun,
      this.isFollow,
      this.id});

  @override
  _FollowUserWidgetState createState() => _FollowUserWidgetState();
}

class _FollowUserWidgetState extends State<FollowUserWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
        width: 70.w,
        height: 70.h,
        alignment: Alignment.center,
        child: Row(
          children: [
            widget.imageUrl != null
                ? Container(
                    height: ScreenUtil().setWidth(55),
                    width: ScreenUtil().setWidth(55),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            widget.imageUrl.toString(),
                          )),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setWidth(55),
                    width: ScreenUtil().setWidth(55),
                    decoration: new BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.userName.toString()[0].toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName,
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                Text(widget.address)
              ],
            ),
            Spacer(),
            widget.isFollow
                ? RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue[100], width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child:
                        SvgPicture.asset('assets/svgs/Iconly-Light-Chat.svg'),
                    onPressed: () {})
                : RaisedButton(
                    elevation: 0,
                    child: Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      widget.isFollow = !widget.isFollow;
                      followUser(widget.id, false,
                          appGet.userMap['user']['id'].toString());

                      setState(() {});
                    })
          ],
        ));
  }
}

class FollowingWidget extends StatefulWidget {
  String imageUrl;
  String userName;
  String address;
  Function fun;
  bool isFollow;
  String id;
  FollowingWidget(
      {this.imageUrl,
      this.address,
      this.userName,
      this.fun,
      this.isFollow,
      this.id});

  @override
  _FollowingWidgetState createState() => _FollowingWidgetState();
}

class _FollowingWidgetState extends State<FollowingWidget> {
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
              child: widget.imageUrl != null
                  ? Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 5.w),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(widget.imageUrl),
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
                        widget.userName[0].toUpperCase(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.userName,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    maxLines: 1,
                  ),
                  AutoSizeText(
                    widget.address ?? '',
                    style: TextStyle(color: Colors.black),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: RaisedButton(
                  elevation: 0,
                  child: AutoSizeText(
                    'Following',
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    widget.isFollow = !widget.isFollow;
                    widget.fun(widget.id.toString(), true);
                    setState(() {});
                  }),
            )
          ],
        ));
  }
}
