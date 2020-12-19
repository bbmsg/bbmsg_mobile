import 'dart:ui';

import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/likeornotcomment.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';

class Listcommentpost extends StatefulWidget {
  final dynamic post;

  Listcommentpost(this.post, {Key key}) : super(key: key);

  @override
  _ListcommentpostState createState() => _ListcommentpostState();
}

class _ListcommentpostState extends State<Listcommentpost> {
  // void newTaskModalBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
  //           height: 40.h,
  //           width: 350.w,
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               border: Border.all(width: 2, color: Colors.blue),
  //               borderRadius: BorderRadius.circular(20)),
  //           child: Scaffold(
  //             backgroundColor: Colors.white,
  //             body: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Flexible(
  //                   child: Container(
  //                     padding: EdgeInsets.only(left: 10.w),
  //                     width: 300.w,
  //                     child: TextField(
  //                       controller: replaycontroller,
  //                       focusNode: appGet.commntFocusNode2,
  //                       decoration: InputDecoration(
  //                           border: InputBorder.none,
  //                           focusedBorder: InputBorder.none,
  //                           fillColor: Colors.white,
  //                           hintText: 'Add reply'),
  //                     ),
  //                   ),
  //                 ),
  //                 Flexible(
  //                     child: Container(
  //                   child: SizedBox(
  //                     width: 60.w,
  //                     child: InkWell(
  //                       onTap: () {
  //                         if (replaycontroller.text == '') {
  //                         } else if (commentpostid == null) {
  //                         } else {
  //                           createreplay(
  //                               commentpostid, replaycontroller.text, 1, null);
  //                         }
  //                       },
  //                       child: Text(
  //                         'Post',
  //                         style: TextStyle(color: Colors.blue, fontSize: 16),
  //                       ),
  //                     ),
  //                   ),
  //                 ))
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();

    appGet.commntFocusNode2 = FocusNode();
    appGet.commentorreply = 1;
  }

  List<bool> isfav = new List<bool>();
  int commentpostid;
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.

    appGet.commntFocusNode2.dispose();

    super.dispose();
  }

  TextEditingController replaycontroller = new TextEditingController();
  AppGet appGet = Get.find();

  int commentidpublic = 0;
  double hicontai = 50;
  bool stopisfav = false;
  bool testico = true;
  bool showmor = false;
  String textstr =
      'gdfgdf dsafasf dfs f dsfsdf dasfsd gfdfg dfg fgdfg sdfsdf sdf dsf sdf sd sdf sdf sdf sdfsd ';

  postimg(String txt, List img) {
    // print('media' + img[1]['url'].toString());

    if (img.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(right: 25.w, left: 25.w),
        child: Text(
          txt,
          textAlign:
              isAlpha(txt.split(' ')[0]) ? TextAlign.left : TextAlign.right,
        ),
      );
    } else {
      print('photo');

      return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: isAlpha(txt.split(' ')[0])
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                child: Text(
                  txt,
                  textAlign: isAlpha(txt) ? TextAlign.left : TextAlign.right,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                color: Colors.red,
                height: 250.h,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: img[0]['url'].toString(),
                ),
              ),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return Scaffold(
        appBar: Headbar('Post Details', 3),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          appGet.setOtherUserMap(
                              widget.post['author']['id'].toString());
                          Get.to(ProfilePage(
                            widget.post['author']['name'].toString(),
                          ));
                        },
                        child: Row(
                          children: [
                            Container(
                              height: ScreenUtil().setWidth(40),
                              width: ScreenUtil().setWidth(40),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: widget.post['author']
                                                ['profile_picture'] !=
                                            null
                                        ? CachedNetworkImageProvider(
                                            widget.post['author']
                                                    ['profile_picture']
                                                .toString(),
                                          )
                                        : AssetImage('assets/pngs/logo.png')),
                              ),
                            ),
                            new SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().setWidth(150),
                                  child: new Text(
                                    widget.post['author']['name'].toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(150),
                                  child: new Text(
                                    // "10 min",
                                    readTimestamp(DateTime.parse(
                                        widget.post['created_at'])),
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  new IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            postimg(widget.post['content'].toString(), widget.post['media']),
            Container(
              child: Postlike(
                widget.post['id'],
                widget.post['my_like'],
                widget.post['likes'],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getAcommentlist(widget.post['id']),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasError
                        ? Container()
                        : snapshot.hasData
                            ? ListView.builder(
                                itemCount: snapshot.data.length,
                                // .compareTo(0),
                                itemBuilder: (BuildContext context, int index) {
                                  // print('list lenngth'+snapshot.data.length.toString());

                                  return Column(
                                    children: [
                                      Divider(),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w, vertical: 5.h),
                                        child: Row(
                                          children: [
                                            appGet.userMap['user']
                                                        ['profile_picture'] !=
                                                    null
                                                ? Container(
                                                    height: ScreenUtil()
                                                        .setWidth(30),
                                                    width: ScreenUtil()
                                                        .setWidth(30),
                                                    decoration:
                                                        new BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image:
                                                          new DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: CachedNetworkImageProvider(
                                                            appGet.userMap[
                                                                    'user'][
                                                                'profile_picture']),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    alignment: Alignment.center,
                                                    height: ScreenUtil()
                                                        .setWidth(30),
                                                    width: ScreenUtil()
                                                        .setWidth(30),
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: primaryColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Text(
                                                      appGet.posts[index]
                                                              ['author']['name']
                                                          .toString()[0]
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    appGet.posts[index]
                                                            ['author']['name']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          snapshot.data[index]
                                                                  ['content']
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Likornotcomment(
                                                              snapshot
                                                                  .data[index]
                                                                      ['id']
                                                                  .toString(),
                                                              snapshot
                                                                  .data[index][
                                                                      'my_like']
                                                                  .toString(),
                                                              1),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        )

        // Stack(children: [
        //   new ,
        //   Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Container(
        //             // color: Colors.red,
        //             child: Addcommentsreply(widget.postid, 1)),
        //       )),
        // ]),
        );
  }
}
