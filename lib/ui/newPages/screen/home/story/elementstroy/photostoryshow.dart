import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/element/timstampclass.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class PhotoStoryshow extends StatefulWidget {
  final String uui;
  final author;
  final List storylist;

  PhotoStoryshow(this.uui, this.storylist, this.author, {Key key})
      : super(key: key);

  @override
  _PhotoStoryshowState createState() => _PhotoStoryshowState();
}

class _PhotoStoryshowState extends State<PhotoStoryshow> {
  AppGet appGet = Get.find();
  List<StoryItem> storyItems;
  final storyController = StoryController();

  @override
  void initState() {
    super.initState();
    // for (var i = 0; i < appGet.story['data'].length; i++) {
    //   storyItems.add(StoryItem.pageImage(
    //       url: appGet.story['data'][i]['media']['url'].toString(),
    //       controller: storyController,
    //       caption: appGet.story['data'][i]['content']));
    // }
  }

  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Story'),
          // ),
          body: Stack(
        children: [
          Hero(
            tag: widget.uui,
            child: StoryView(
              inline: true,
              storyItems: [
                for (var i = 0; i < widget.storylist.length; i++)
                  (widget.storylist[i]['media'] != null
                      ? (widget.storylist[i]['media']['url']
                                  .toString()
                                  .substring(widget.storylist[i]['media']['url']
                                          .toString()
                                          .length -
                                      3) ==
                              'mp4'
                          ? StoryItem.pageVideo(
                              widget.storylist[i]['media']['url'].toString(),
                              controller: storyController,
                              duration: Duration(seconds: 10),
                              caption:
                                  widget.storylist[i]['content'].toString())
                          : StoryItem.pageImage(
                              url: widget.storylist[i]['media']['url']
                                  .toString(),
                              controller: storyController,
                              // imageFit: BoxFit.cover,
                              caption:
                                  widget.storylist[i]['content'].toString()))
                      : StoryItem.text(
                          title: widget.storylist[i]['content'].toString(),
                          backgroundColor: Colors.orange,
                          roundedTop: true,
                        )),
              ],
              repeat: false,
              onStoryShow: (s) {
                print("Showing a story");
                // setState(() {});
                appGet.completcycle = false.obs;
              },
              onComplete: () {
                logger.e("Completed a cycle");
                appGet.completcycle = true.obs;
                appGet.currentPage++;
                // Get.back();                print('indexxxx $indexaa');

                appGet.pagcontroller.animateToPage(appGet.currentPage,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeIn);
              },
              progressPosition: ProgressPosition.top,
              controller: storyController,
            ),
          ),
          // Container(
          //   color: Colors.white,
          //   child: Center(
          //       child: Hero(
          //     child: Container(
          //       height: 400,
          //       width: double.infinity,
          //       child: widget.photo != null
          //           ? Image.network(
          //               widget.photo,
          //               fit: BoxFit.fill,
          //             )
          //           : Image.asset('assets/pngs/back.jpg'),
          //     ),
          //     tag: widget.uui,
          //   )),
          // ),

          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     vertical: 60.h,
          //     horizontal: 20.w,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Row(
          //         children: [
          //           widget.author['profile_picture'] != null
          //               ? Container(
          //                   height: ScreenUtil().setWidth(35),
          //                   width: ScreenUtil().setWidth(35),
          //                   decoration: new BoxDecoration(
          //                     shape: BoxShape.circle,
          //                     image: new DecorationImage(
          //                         fit: BoxFit.fill,
          //                         image: CachedNetworkImageProvider(
          //                           widget.author['profile_picture'].toString(),
          //                         )),
          //                   ),
          //                 )
          //               : Container(
          //                   alignment: Alignment.center,
          //                   height: ScreenUtil().setWidth(40),
          //                   width: ScreenUtil().setWidth(40),
          //                   decoration: new BoxDecoration(
          //                     color: primaryColor,
          //                     shape: BoxShape.circle,
          //                   ),
          //                   child: Text(
          //                     widget.author['name'].toString()[0].toUpperCase(),
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //           SizedBox(
          //             width: 10.w,
          //           ),
          //           Text(
          //             widget.author['name'],
          //             style: TextStyle(
          //               fontSize: 20,
          //               color: Colors.white,
          //             ),
          //           ),
          //           SizedBox(
          //             width: 10.w,
          //           ),
          //           SizedBox(
          //             width: ScreenUtil().setWidth(150),
          //             child: new Text(
          //               // "10 min",
          //               readTimestamp(
          //                   DateTime.parse(widget.storylist[0]['created_at'])),
          //               style: TextStyle(color: Colors.grey[500]),
          //             ),
          //           ),
          //         ],
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Get.back();
          //         },
          //         child: Icon(
          //           Icons.close,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }
}
