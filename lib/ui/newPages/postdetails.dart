import 'dart:io';

import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'commentscard.dart';

class PostDetailscr extends StatefulWidget {
  final String id;
  final String userimge;
  final String username;
  final String postImg;
  final String likes;
  final String comments;
  final String content;
  PostDetailscr(this.id, this.userimge, this.username, this.postImg, this.likes,
      this.comments, this.content,
      {Key key})
      : super(key: key);

  @override
  _PostDetailscrState createState() => _PostDetailscrState();
}

class _PostDetailscrState extends State<PostDetailscr> {
  String ids;
  @override
  void initState() {
    ids = widget.id;
    //  getPosts(userId: ids);
    super.initState();
  }

  bool isPressed = false;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: HexColor('#200E32'),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(
              width: isPortrait
                  ? ScreenUtil().setWidth(125)
                  : ScreenUtil().setWidth(125),
            ),
            Text(
              'Post Details',
              style: TextStyle(
                  color: HexColor('#1A1818'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: isPortrait
                  ? ScreenUtil().setWidth(18)
                  : ScreenUtil().setWidth(18),
              left: isPortrait
                  ? ScreenUtil().setWidth(18)
                  : ScreenUtil().setWidth(18),
              top: isPortrait
                  ? ScreenUtil().setHeight(18)
                  : ScreenUtil().setHeight(18),
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: isPortrait
                      ? ScreenUtil().setWidth(40)
                      : ScreenUtil().setWidth(30),
                  height: isPortrait
                      ? ScreenUtil().setHeight(40)
                      : ScreenUtil().setHeight(120),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(widget.userimge)),
                  ),
                ),
                SizedBox(
                  width: isPortrait
                      ? ScreenUtil().setWidth(12)
                      : ScreenUtil().setWidth(12),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: TextStyle(
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(16)
                              : ScreenUtil().setSp(10)),
                    ),
                    Text(
                      '10 min',
                      style: TextStyle(
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(12)
                              : ScreenUtil().setSp(7),
                          color: Colors.grey[400]),
                    )
                  ],
                ),
                SizedBox(
                  width: isPortrait
                      ? ScreenUtil().setWidth(120)
                      : ScreenUtil().setWidth(180),
                ),
                Icon(Icons.more_vert)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(14)
                    : ScreenUtil().setHeight(14),
                left: isPortrait
                    ? ScreenUtil().setWidth(18)
                    : ScreenUtil().setWidth(18),
                right: isPortrait
                    ? ScreenUtil().setWidth(18)
                    : ScreenUtil().setWidth(18)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(335)
                  : ScreenUtil().setWidth(335),
              // height: isPortrait
              //     ? ScreenUtil().setHeight(335)
              //     : ScreenUtil().setHeight(335),
              child: Text(
                widget.content,
                style: TextStyle(
                    fontSize: isPortrait
                        ? ScreenUtil().setSp(14)
                        : ScreenUtil().setSp(10)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: isPortrait
                  ? ScreenUtil().setHeight(26)
                  : ScreenUtil().setHeight(26),
            ),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(375)
                  : ScreenUtil().setWidth(400),
              height: isPortrait
                  ? ScreenUtil().setHeight(270)
                  : ScreenUtil().setHeight(800),
              // color: Colors.grey,
              child: Image.network(
                widget.postImg,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(12)
                    : ScreenUtil().setHeight(12),
                left: isPortrait
                    ? ScreenUtil().setWidth(18)
                    : ScreenUtil().setWidth(18)),
            child: Container(
              width: isPortrait
                  ? ScreenUtil().setWidth(310)
                  : ScreenUtil().setWidth(310),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: isPortrait
                        ? ScreenUtil().setWidth(130)
                        : ScreenUtil().setWidth(130),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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
                        // SvgPicture.asset('assets/svgs/Shape.svg'),
                        Text(widget.likes),
                        SvgPicture.asset('assets/svgs/CombinedShape.svg'),
                        Text(widget.comments),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: isPortrait
                          ? ScreenUtil().setWidth(28)
                          : ScreenUtil().setWidth(28),
                    ),
                    child: SvgPicture.asset('assets/svgs/ShareIcon.svg'),
                  )
                ],
              ),
            ),
          ),
          CommentsCard(),
          CommentsCard(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: isPortrait
                    ? ScreenUtil().setHeight(14)
                    : ScreenUtil().setHeight(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: isPortrait
                        ? ScreenUtil().setWidth(285)
                        : ScreenUtil().setWidth(285),
                    height: isPortrait
                        ? ScreenUtil().setHeight(35)
                        : ScreenUtil().setHeight(90),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: HexColor('#00ADEE'))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: isPortrait
                              ? ScreenUtil().setWidth(15)
                              : ScreenUtil().setWidth(15),
                          right: isPortrait
                              ? ScreenUtil().setWidth(15)
                              : ScreenUtil().setWidth(15)),
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          suffixIcon: SvgPicture.asset(
                            'assets/svgs/smile.svg',
                            height: ScreenUtil().setHeight(18),
                            width: ScreenUtil().setWidth(18),
                          ),
                          hintText: 'Add Comment',
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintStyle: TextStyle(
                              color: HexColor('#00ADEE'),
                              fontSize: isPortrait
                                  ? ScreenUtil().setSp(12)
                                  : ScreenUtil().setSp(8)),
                        ),
                      ),
                      // Text(
                      //   'Add Comment',
                      //   style: TextStyle(
                      //       color: HexColor('#00ADEE'),
                      //       fontSize: isPortrait
                      //           ? ScreenUtil().setSp(12)
                      //           : ScreenUtil().setSp(8)),
                      // ),
                      // SvgPicture.asset('assets/svgs/smile.svg')
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // File fff;
                      // createComment(
                      //   int.parse(widget.id),
                      // );
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                          color: HexColor('#00ADEE'),
                          fontSize: isPortrait
                              ? ScreenUtil().setSp(14)
                              : ScreenUtil().setSp(10)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
