import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';

import 'package:bbmsg_mobile/ui/newPages/postdetails.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/commentbyid.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../story/insta_stories.dart';

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  AppGet appGet = Get.find();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return StreamBuilder(
      stream: getPosts().asStream(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  getAcomment(snapshot.data['data'][index]['id']);
                  return index == 0
                      ? new SizedBox(
                          child: InstaStories(),
                          height: ScreenUtil().setWidth(187),
                        )
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
                                          Get.to(PostDetailscr(
                                            snapshot.data['data'][index]['id']
                                                .toString(),
                                            snapshot.data['data'][index]
                                                    ['author']
                                                    ['profile_picture']
                                                .toString(),
                                            snapshot.data['data'][index]
                                                    ['author']['name']
                                                .toString(),
                                            snapshot.data['data'][index]
                                                    ['media']
                                                .toString(),
                                            snapshot.data['data'][index]
                                                    ['likes']
                                                .toString(),
                                            snapshot.data['data'][index]
                                                    ['comments']
                                                .toString(),
                                            snapshot.data['data'][index]
                                                    ['content']
                                                .toString(),
                                          ));
                                        },
                                        child: new Container(
                                          height: ScreenUtil().setWidth(40),
                                          width: ScreenUtil().setWidth(40),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                  snapshot.data['data'][index]
                                                          ['author']
                                                          ['profile_picture']
                                                      .toString(),
                                                )),
                                          ),
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
                                              snapshot.data['data'][index]
                                                      ['author']['name']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(150),
                                            child: new Text(
                                              "10 min",
                                              style: TextStyle(
                                                  color: Colors.grey[500]),
                                            ),
                                          ),
                                        ],
                                      )
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
                            Padding(
                              padding: const EdgeInsets.all(16.0),
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
                                    " pawankumar, pk and 528,331 others",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 200,
                                  height: 200,
                                  child: Commentbyid()),
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
                                          image: new NetworkImage(
                                            snapshot.data['data'][index]
                                                    ['author']
                                                    ['profile_picture']
                                                .toString(),
                                          )),
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 10.0,
                                  ),
                                  new SizedBox(
                                    width: ScreenUtil().setWidth(284),
                                    height: ScreenUtil().setHeight(29),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 0, left: 2, right: 10),
                                        child: Center(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0,
                                                  color: Colors.grey[200])),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  textAlign: TextAlign.left,
                                                  // controller: searchCtrl,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    suffixIcon: SizedBox(
                                                      width: ScreenUtil()
                                                          .setWidth(140),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                                size: 12,
                                                              ),
                                                              onPressed: () {}),
                                                          IconButton(
                                                              icon: Icon(
                                                                FontAwesomeIcons
                                                                    .smile,
                                                                color: Colors
                                                                        .yellow[
                                                                    700],
                                                                size: 12,
                                                              ),
                                                              onPressed: () {}),
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                                size: 12,
                                                              ),
                                                              onPressed: () {})
                                                        ],
                                                      ),
                                                    ),

                                                    hintText: 'Add comment..',
                                                    hintStyle:
                                                        TextStyle(fontSize: 16),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        //   //     width: 0,
                                                        // style: BorderStyle.none,
                                                      ),
                                                    ),
                                                    // filled: true,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            top: 0, left: 10),
                                                    // fillColor: Colors.grey[200],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text("1 Day Ago",
                                  style: TextStyle(color: Colors.grey)),
                            )
                          ],
                        );
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
