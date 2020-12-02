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
        height: 75.h,
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5.w),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      widget.fun(widget.id);
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
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5.w),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.userName,
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                Text(widget.address ?? '')
              ],
            ),
            Spacer(),
            RaisedButton(
                elevation: 0,
                child: Text(
                  'Following',
                  style: TextStyle(color: Colors.white),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  widget.isFollow = !widget.isFollow;
                  widget.fun(widget.id);
                  setState(() {});
                })
          ],
        ));
  }
}
