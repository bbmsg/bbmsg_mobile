import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/opennewstory.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'instalist/insta_list.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/elementstroy/photostoryshow.dart';

class InstaBody extends StatelessWidget {
  Function fun;
  InstaBody(this.fun);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new ListView(
      children: <Widget>[
        // Container(height: 200.h, color: Colors.white, child: HeaderMock()),
        Container(child: InstaList(fun)),
      ],
    );
  }
}

class HeaderMock extends StatelessWidget {
  Function fun;
  HeaderMock(this.fun);
  AppGet appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 16.0),
            child: Row(
              children: [
                appGet.userMap['user']['profile_picture'] != null
                    ? Container(
                        height: ScreenUtil().setWidth(55),
                        width: ScreenUtil().setWidth(55),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                appGet.userMap['user']['profile_picture']
                                    .toString(),
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
                          appGet.userMap['user']['name']
                              .toString()[0]
                              .toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                new SizedBox(
                  width: 8.0.w,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          width: ScreenUtil().setWidth(150),
                          child: new Text(
                            appGet.userMap['user']['name'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            fun();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: Alignment.centerLeft,
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff9B9B9B)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('What\'s in your mind?'),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          appGet.story['data'] != null
              ? Container(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: appGet.story['data'].length,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? appGet.story['data'][index]['author']
                                      ['profile_picture'] !=
                                  null
                              ? InkWell(
                                  onTap: () {
                                    print('object');
                                    Get.to(Opennewstory());
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff047AF2),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.4),
                                              BlendMode.dstATop),
                                          image: CachedNetworkImageProvider(
                                              appGet.story['data'][index]
                                                      ['author']
                                                  ['profile_picture']),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    print('object');
                                    Get.to(Opennewstory());
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff047AF2),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.4),
                                              BlendMode.dstATop),
                                          image: AssetImage(
                                              'assets/pngs/back2.jpg'),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )),
                                  )
                                  //  Container(
                                  //   alignment: Alignment.center,
                                  //   height: ScreenUtil().setWidth(40),
                                  //   width: ScreenUtil().setWidth(40),
                                  //   decoration: new BoxDecoration(
                                  //     color: primaryColor,
                                  //     shape: BoxShape.circle,
                                  //   ),
                                  //   child: Text(
                                  //     appGet.userMap['user']['name']
                                  //             .toString()[0]
                                  //             .toUpperCase() +
                                  //         ' +',
                                  //     style: TextStyle(
                                  //         color: Colors.white,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // ),
                                  )
                          : appGet.story['data'][index - 1]['media'] != null
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PhotoStoryshow(
                                                  'tt',
                                                  appGet.story['data']
                                                          [index - 1]['media']
                                                          ['url']
                                                      .toString(),
                                                  appGet.story['data']
                                                          [index - 1]['content']
                                                      .toString(),
                                                )));
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff047AF2),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              appGet.story['data'][index - 1]
                                                      ['media']['url']
                                                  .toString()),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Center(
                                      child: Text(appGet.story['data']
                                              [index - 1]['content']
                                          .toString()),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PhotoStoryshow(
                                                  'tt',
                                                  null,
                                                  appGet.story['data']
                                                          [index - 1]['content']
                                                      .toString(),
                                                )));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    height: 70.h,
                                    width: 70.w,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor,
                                    ),
                                    child: Text(
                                      appGet.story['data'][index - 1]['author']
                                              ['name']
                                          .toString()
                                          .split(' ')[0]
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                    },
                  ),
                )
              : Container()
        ],
      );
    });
  }
}
