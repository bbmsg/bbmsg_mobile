import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';

import 'package:bbmsg_mobile/ui/newPages/postdetails.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/commentbyid.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../story/insta_stories.dart';

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  int griditm = 1;
  String isarabic;

  postimg(String txt, List img) {
    // print('media' + img[1]['url'].toString());

    if (img.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(right: 25.w, left: 25.w),
        child: Text(
          txt,
          textAlign: TextAlign.right,
        ),
      );
    } else {
      print('photo');

      img.length > 1 ? griditm = 2 : griditm = 1;
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: griditm,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
            childAspectRatio: 0.9),
        shrinkWrap: true,
        itemCount: img.length,
        itemBuilder: (context, index) {
          // print('media' + img[index]['url'].toString());
          return Container(
              width: 200.w,
              child: Column(
                children: [
                  Text(
                    txt,
                    textAlign: TextAlign.right,
                  ),
                  Image.network(
                    img[index]['url'].toString(),
                    fit: BoxFit.fill,
                  ),
                ],
              ));
        },
      );
    }
  }

  AppGet appGet = Get.find();
  // bool isPressed = false;
  TextEditingController commentcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return FutureBuilder(
      future: getPosts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  getAcomment(snapshot.data['data'][index]['id']);

                  return index == 0
                      ? InstaStories()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 8.0, 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          appGet.setOtherUserMap(snapshot
                                              .data['data'][index]['id']
                                              .toString());
                                          Get.to(ProfilePage(
                                            snapshot.data['data'][index]
                                                    ['author']['name']
                                                .toString(),
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
                                                    image: snapshot.data['data']
                                                                        [index]
                                                                    ['author'][
                                                                'profile_picture'] !=
                                                            null
                                                        ? CachedNetworkImageProvider(
                                                            snapshot
                                                                .data['data']
                                                                    [index]
                                                                    ['author'][
                                                                    'profile_picture']
                                                                .toString(),
                                                          )
                                                        : AssetImage(
                                                            'assets/pngs/logo.png')),
                                              ),
                                            ),
                                            new SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: ScreenUtil()
                                                      .setWidth(150),
                                                  child: new Text(
                                                    snapshot.data['data'][index]
                                                            ['author']['name']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil()
                                                      .setWidth(150),
                                                  child: new Text(
                                                    "10 min",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[500]),
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
                            GestureDetector(
                              onTap: () {
                                Get.to(PostDetailscr(
                                  snapshot.data['data'][index]['id'].toString(),
                                  snapshot.data['data'][index]['author']
                                          ['profile_picture']
                                      .toString(),
                                  snapshot.data['data'][index]['author']['name']
                                      .toString(),
                                  snapshot.data['data'][index]['media']
                                      .toString(),
                                  snapshot.data['data'][index]['likes']
                                      .toString(),
                                  snapshot.data['data'][index]['comments']
                                      .toString(),
                                  snapshot.data['data'][index]['content']
                                      .toString(),
                                ));
                              },
                              child: Flexible(
                                fit: FlexFit.loose,

                                ///empty imag post
                                child: new Image.network(
                                  snapshot.data['data'][index]['media']
                                      .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            postimg(
                                snapshot.data['data'][index]['content']
                                    .toString(),
                                snapshot.data['data'][index]['media']),
                            Container(
                              child: Postlike(
                                snapshot.data['data'][index]['id'],
                                snapshot.data['data'][index]['likes']
                                    .toString(),
                                snapshot.data['data'][index]['comments']
                                    .toString(),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Liked by" +
                                    ' ' +
                                    appGet.commentpost['data'][0]['author']
                                        ['name'] +
                                    ' ' +
                                    (appGet.commentpost['data'].length - 1)
                                        .toString() +
                                    'other',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(child: Commentbyid()),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 0.0, 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    height: ScreenUtil().setWidth(22),
                                    width: ScreenUtil().setWidth(22),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: appGet.userMap['user']
                                                    ['profile_picture'] !=
                                                null
                                            ? CachedNetworkImageProvider(
                                                appGet.userMap['user']
                                                    ['profile_picture'])
                                            : AssetImage(
                                                'assets/pngs/logo.png'),
                                      ),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 10.0,
                                  ),
                                  new Expanded(
                                    child: Container(
                                        height: 50.h,
                                        child: Center(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0,
                                                  color: Colors.grey[200])),
                                          child: Expanded(
                                            child: TextField(
                                              textAlign: TextAlign.left,
                                              controller: commentcontroller,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText: 'Add comment..',
                                                hintStyle:
                                                    TextStyle(fontSize: 16),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                    //   //     width: 0,
                                                    // style: BorderStyle.none,
                                                  ),
                                                ),
                                                // filled: true,
                                                contentPadding: EdgeInsets.only(
                                                    top: 0, left: 10),
                                                // fillColor: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        ))),
                                  ),
                                  SizedBox(width: 10.w)
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text("1 Day Ago",
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Divider()
                          ],
                        );
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
