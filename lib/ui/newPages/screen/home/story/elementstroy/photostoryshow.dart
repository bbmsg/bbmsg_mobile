import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class PhotoStoryshow extends StatefulWidget {
  final String uui;

  final List storylist;

  PhotoStoryshow(this.uui, this.storylist, {Key key}) : super(key: key);

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
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Story'),
      // ),
      body: Stack(
        children: [
          Hero(
            tag: widget.uui,
            child: StoryView(
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
                appGet.completcycle = false.obs;

              },
              onComplete: () {
                print("Completed a cycle");
                appGet.completcycle = true.obs;
              },
              progressPosition: ProgressPosition.top,
              controller: storyController,
            ),
          ),
          //            Container(
          //     color: Colors.white,

          //     child: Center(
          //         child: Hero(
          //       child: Container(
          //         height: 400,
          //         width: double.infinity,
          //         child: widget.photo != null
          //             ? Image.network(
          //                 widget.photo,
          //                 fit: BoxFit.fill,
          //               )
          //             : Image.asset('assets/pngs/back.jpg'),
          //       ),
          //       tag: widget.uui,
          //     )),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: 16.0),
          //   child: Center(
          //     child: Text(
          //       widget.content,
          //       style: TextStyle(fontSize: 20),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
