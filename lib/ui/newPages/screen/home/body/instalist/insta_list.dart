import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:intl/intl.dart';

import 'package:bbmsg_mobile/ui/newPages/postdetails.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/addcomment.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/listpostcomment/commentbyid.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/postlike.dart';
import 'package:bbmsg_mobile/ui/pages/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';
import '../../story/insta_stories.dart';

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
          textAlign: isAlpha(txt) ? TextAlign.left : TextAlign.right,
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
        itemBuilder: (context, indeximg) {
          // print('media' + img[index]['url'].toString());
          return Container(
              width: 200.w,
              child: Column(
                crossAxisAlignment: isAlpha(txt)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Text(
                      txt,
                      textAlign:
                          isAlpha(txt) ? TextAlign.left : TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Image.network(
                    img[indeximg]['url'].toString(),
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
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    setState(() {});
    return appGet.posts.isNullOrBlank
        ? CircularProgressIndicator()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: appGet.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? InstaStories()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      appGet.setOtherUserMap(appGet
                                          .posts['data'][index]['author']['id']
                                          .toString());
                                      Get.to(ProfilePage(
                                        appGet.posts['data'][index]['author']
                                                ['name']
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
                                                image: appGet.posts['data']
                                                                    [index]
                                                                ['author'][
                                                            'profile_picture'] !=
                                                        null
                                                    ? CachedNetworkImageProvider(
                                                        appGet.posts['data']
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
                                              width: ScreenUtil().setWidth(150),
                                              child: new Text(
                                                appGet.posts['data'][index]
                                                        ['author']['name']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(150),
                                              child: new Text(
                                                // "10 min",
                                                readTimestamp(DateTime.parse(
                                                    appGet.posts['data'][index]
                                                        ['created_at'])),
                                                style: TextStyle(
                                                    color: Colors.grey[500]),
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
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(PostDetailscr(
                        //       appGet.posts['data'][index]['id'].toString(),
                        //       appGet.posts['data'][index]['author']
                        //               ['profile_picture']
                        //           .toString(),
                        //       appGet.posts['data'][index]['author']['name']
                        //           .toString(),
                        //       appGet.posts['data'][index]['media'].toString(),
                        //       appGet.posts['data'][index]['likes'].toString(),
                        //       appGet.posts['data'][index]['comments']
                        //           .toString(),
                        //       appGet.posts['data'][index]['content'].toString(),
                        //     ));
                        //   },
                        //   child: new Image.network(
                        //     appGet.posts['data'][index]['media'][0]['url'].toString(),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        postimg(
                            appGet.posts['data'][index]['content'].toString(),
                            appGet.posts['data'][index]['media']),
                        Container(
                          child: Postlike(
                            appGet.posts['data'][index]['id'],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: appGet.posts['data'][index]['id'] > 0
                                  ? Commentbyid(
                                      appGet.posts['data'][index]['id'])
                                  : Commentbyid(0)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 8.0),
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
                                        ? CachedNetworkImageProvider(appGet
                                            .userMap['user']['profile_picture'])
                                        : AssetImage('assets/pngs/logo.png'),
                                  ),
                                ),
                              ),
                              new SizedBox(
                                width: 10.0,
                              ),
                              Addcomments(appGet.posts['data'][index]['id']),
                              SizedBox(width: 10.w)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                              readTimestamp(DateTime.parse(appGet.posts['data']
                                          [index]['created_at']
                                      .toString())) +
                                  ' Ago',
                              style: TextStyle(color: Colors.grey)),
                        ),
                        Divider()
                      ],
                    );
            });
  }
}
