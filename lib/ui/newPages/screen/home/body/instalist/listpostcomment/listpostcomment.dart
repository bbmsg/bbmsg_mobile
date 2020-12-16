import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/listreply/listreplycomment.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/headappbars/head_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Listcommentpost extends StatefulWidget {
  final int postid;
  Listcommentpost(this.postid, {Key key}) : super(key: key);

  @override
  _ListcommentpostState createState() => _ListcommentpostState();
}

class _ListcommentpostState extends State<Listcommentpost> {
  void newTaskModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
            height: 40.h,
            width: 350.w,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w),
                      width: 300.w,
                      child: TextField(
                        controller: replaycontroller,
                        focusNode: myFocusNode,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Add reply'),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    child: SizedBox(
                      width: 60.w,
                      child: InkWell(
                        onTap: () {
                          if (replaycontroller.text == '') {
                          } else if (commentpostid == null) {
                          } else {
                            createreplay(
                                commentpostid, replaycontroller.text, 1, null);
                          }
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          );
        });
  }

  FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    getAcomment1(widget.postid).then((value) {
      setState(() {});
    });
  }

  List<bool> isfav = new List<bool>();
  int commentpostid;
  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  TextEditingController replaycontroller = new TextEditingController();
  AppGet appGet = Get.find();
  listrplay(int commentid) {
    print(commentid);
    getAreplay(commentid).then((value) {
      print('val' + appGet.commentreplytbyid.length.toString());
      if (value == null) {
        return Container();
      } else {
        // setState(() {
        //   hicontai = (appGet.commentreplytbyid.length * 30).toDouble();
        // });
        return Container(
          child: ListView.builder(
            itemCount: appGet.commentreplytbyid.length.compareTo(0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 30.h,
                width: 220.w,
                color: Colors.red,
                child: Text(appGet.commentreplytbyid['content'].toString()),
              );
            },
          ),
        );
      }
    });
  }

  int commentidpublic = 0;
  double hicontai = 50;
  bool stopisfav = false;
  bool testico = true;
  @override
  Widget build(BuildContext context) {
    // getAcomment(widget.postid);
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return Scaffold(
      appBar: Headbar('Comment', 2),
      body: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
            height: 40.h,
            width: 350.w,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(20)),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w),
                      width: 300.w,
                      child: TextField(
                        controller: replaycontroller,
                        focusNode: myFocusNode,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            fillColor: Colors.white,
                            hintText: 'Add Comment'),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Container(
                    child: SizedBox(
                      width: 60.w,
                      child: InkWell(
                        onTap: () {
                          if (replaycontroller.text == '') {
                          
                          } else {
                            createComment(widget.postid, replaycontroller.text,
                                    null, null)
                                .then((value) {
                              getAcomment1(widget.postid);
                            });
                            // createreplay(commentpostid, replaycontroller.text,
                            //     1, null);
                          }
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        // new
        // FutureBuilder(
        //   future: getAcomment1(widget.postid),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     return
        appGet.commentpostbyidlist.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: appGet.commentpostbyidlist.length,
                itemBuilder: (BuildContext context, int index) {
                  if (stopisfav == false) {
                    isfav.add(false);
                    if (appGet.commentpostbyidlist['data'][index]['likes'] ==
                        1) {
                      isfav[index] = true;
                    }
                  }
                  if (index == appGet.commentpostbyidlist.length) {
                    stopisfav = true;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              width: 420.w,
                              height: hicontai.h,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5.h),
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: appGet.commentpostbyidlist[
                                                              'data'][index]
                                                          ['author']
                                                      ['profile_picture'] !=
                                                  null
                                              ? CachedNetworkImageProvider(
                                                  appGet.commentpostbyidlist[
                                                          'data'][index]
                                                          ['author']
                                                          ['profile_picture']
                                                      .toString(),
                                                )
                                              : AssetImage(
                                                  'assets/pngs/logo.png')),
                                    ),
                                  ),
                                  Container(
                                    height: ScreenUtil().setWidth(40),
                                    width: ScreenUtil().setWidth(40),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                            appGet.commentpostbyidlist['data']
                                                    [index]['author']
                                                    ['profile_picture']
                                                .toString(),
                                          )),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      appGet.commentpostbyidlist['data'][index]
                                              ['author']['name']
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                        top: 5.h, right: 10.w, left: 5.w),
                                    child: Text(
                                      appGet.commentpostbyidlist['data'][index]
                                              ['content']
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 90.w),
                              child: Row(
                                children: [
                                  Text(readTimestamp(DateTime.parse(
                                      appGet.commentpostbyidlist['data'][index]
                                          ['created_at']))),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        //     newTaskModalBottomSheet(context);
                                        myFocusNode.requestFocus();
                                        commentpostid =
                                            appGet.commentpostbyidlist['data']
                                                [index]['id'];
                                      },
                                      child: Text('Reply'))
                                ],
                              ),
                            ),
                            // Visibility(
                            //     visible: false,
                            //     child: Listrplaycomment(commentidpublic)),
                            Visibility(
                              visible: false,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    commentidpublic =
                                        appGet.commentpostbyidlist['data']
                                            [index]['id'];
                                  });
                                },
                                child: Center(
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
                                        child:
                                            Center(child: Text('View reply')),
                                      ),
                                      Container(
                                        width: 120.w,
                                        height: 1.5,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            isfav[index]
                                // testico
                                ? Icons.favorite
                                : FontAwesomeIcons.heart,
                            color: isfav[index]
                                // testico
                                ? Colors.red
                                : Colors.black,
                            size: 14,
                          ),
                          onPressed: () {
                            setState(() {
                              isfav[index] = !isfav[index];
                            });
                            setState(() {
                              print(isfav[index].toString() + index.toString());

                              isfav[index]
                                  ? likecomment(appGet
                                      .commentpostbyidlist['data'][index]['id'])
                                  : removelike(
                                      appGet.commentpostbyidlist['data'][index]
                                          ['id']);
                            });
                          }),
                    ],
                  );
                },
              )
            : Center(child: CircularProgressIndicator())
      ]),
    );
  }
}
