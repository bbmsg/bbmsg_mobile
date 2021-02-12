import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/likeornotcomment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Listrplaycommentt extends StatefulWidget {
  final int commentid;
  Listrplaycommentt(this.commentid, {Key key}) : super(key: key);

  @override
  _ListrplaycommentState createState() => _ListrplaycommentState();
}

class _ListrplaycommentState extends State<Listrplaycommentt> {
  AppGet appGet = Get.find();

  int commentidpublic = 0;
  double hicontai = 50;
  bool stopisfav = false;
  bool testico = true;

  @override
  void initState() {
    super.initState();
    appGet.commntFocusNode2 = FocusNode();
  }

  void dispose() {
    appGet.commntFocusNode2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getAcomment(widget.postid);

    return Container(
      child: Stack(children: [
        Container(
          child: new FutureBuilder(
              future: getAreplay(widget.commentid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                // print(snapshot.data['data'].length.toString());
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                        child: SizedBox(
                      width: 20.w,
                      height: 22.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ));
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data['data'].length,
                        // .compareTo(0),
                        itemBuilder: (BuildContext context, int index) {
                          // print('list lenngth'+snapshot.data.length.toString());

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 300.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 100.w, right: 10),
                                      width: 300.w,
                                      height: hicontai.h,
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 5.h),
                                            height: 20.h,
                                            width: 20.w,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  scale: 1,
                                                  fit: BoxFit.fill,
                                                  image: snapshot.data['data']
                                                                      [index]
                                                                  ['author'][
                                                              'profile_picture'] !=
                                                          null
                                                      ? CachedNetworkImageProvider(
                                                          snapshot.data['data']
                                                                  [index]
                                                                  ['author'][
                                                                  'profile_picture']
                                                              .toString(),
                                                        )
                                                      : AssetImage(
                                                          'assets/pngs/logo.png')),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data['data'][index]
                                                    ['author']['name']
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            width: 100.w,
                                            padding: EdgeInsets.only(
                                                top: 5.h,
                                                right: 10.w,
                                                left: 5.w),
                                            child: SizedBox(
                                              width: 150.w,
                                              child: Text(
                                                snapshot.data['data'][index]
                                                        ['content']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 120.w),
                                      child: Row(
                                        children: [
                                          Text(readTimestamp(DateTime.parse(
                                              snapshot.data['data'][index]
                                                  ['created_at']))),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Visibility(
                                            visible: snapshot.data['data']
                                                        [index]['likes'] ==
                                                    0
                                                ? false
                                                : true,
                                            child: InkWell(
                                                onTap: () {},
                                                child: Text(snapshot
                                                                .data['data']
                                                            [index]['likes'] >
                                                        1
                                                    ? snapshot.data['data']
                                                                [index]['likes']
                                                            .toString() +
                                                        ' likes'
                                                    : (snapshot.data['data']
                                                                [index]['likes']
                                                            .toString() +
                                                        ' like'))),
                                          ),
                                          Visibility(
                                            visible: snapshot.data['data']
                                                        [index]['likes'] ==
                                                    0
                                                ? false
                                                : true,
                                            child: SizedBox(
                                              width: 20.w,
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                //     newTaskModalBottomSheet(context);
                                                appGet.commntFocusNode2
                                                    .requestFocus();
                                                appGet.commentorreply = 2;
                                                print('replytypr' +
                                                    appGet.commentorreply
                                                        .toString());
                                              },
                                              child: Text('Reply'))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 70.w,
                                child: Likornotcommentt(
                                    snapshot.data['data'][index]['id']
                                        .toString(),
                                    snapshot.data['data'][index]['my_like']
                                        .toString(),
                                    2),
                              )
                            ],
                          );
                        },
                      );
                }
              }),
        )
      ]),
    );
  }
}
