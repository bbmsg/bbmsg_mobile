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
  final author;
  final List storylist;

  PhotoStoryshow(this.storylist, this.author, {Key key}) : super(key: key);

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
          body: StoryView(
        inline: true,
        storyItems: widget.storylist.map((e) {
          return e['media'] != null
              ? StoryItem.pageImage(
                  url: e['media']['url'].toString(),
                  controller: storyController,
                  // imageFit: BoxFit.cover,
                  caption: e['content'].toString())
              : StoryItem.text(
                  title: e['content'].toString(),
                  backgroundColor: Colors.orange,
                  roundedTop: true,
                );
        }).toList(),
        repeat: false,
        onComplete: () {
          appGet.currentPage++;
          if (appGet.currentPage == appGet.numberOfStories) {
            appGet.currentPage = 0;
            Get.back();
          } else {
            appGet.pagcontroller.animateToPage(appGet.currentPage,
                duration: Duration(milliseconds: 350), curve: Curves.easeIn);
          }
        },
        controller: storyController,
      )),
    );
  }
}
