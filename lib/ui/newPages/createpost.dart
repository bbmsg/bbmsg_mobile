import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/getimage.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Createpostscr extends StatefulWidget {
  Createpostscr({Key key}) : super(key: key);

  @override
  _CreatepostscrState createState() => _CreatepostscrState();
}

class _CreatepostscrState extends State<Createpostscr> {
  AppGet appget = Get.find();
  String dropdownValue = 'Public';

  TextEditingController contentController = new TextEditingController();
  List<Asset> images = List<Asset>();

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Text(
              'Create Post',
              style: TextStyle(
                  // color: HexColor('#1A1818'),
                  fontSize: isPortrait
                      ? ScreenUtil().setSp(16)
                      : ScreenUtil().setSp(10)),
            ),
            GestureDetector(
              onTap: () async {
                bool result = appGet.userMap.isEmpty
                    ? false
                    : await createPost(contentController.text, images);
                if (result == true) {
                  this.images = [];
                  contentController.clear();
                  Get.back();
                  setState(() {});
                }
              },
              child: Text(
                'Post',
                style: TextStyle(
                    color: HexColor('#00ADEE'),
                    fontSize: isPortrait
                        ? ScreenUtil().setSp(16)
                        : ScreenUtil().setSp(10)),
              ),
            )
          ],
        ),
      ),
      body: appGet.userMap.isEmpty
          ? Container(child: Center(child: CircularProgressIndicator()))
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isPortrait
                          ? ScreenUtil().setHeight(8)
                          : ScreenUtil().setHeight(20),
                      left: isPortrait
                          ? ScreenUtil().setWidth(18)
                          : ScreenUtil().setWidth(18)),
                  child: Row(
                    children: [
                      appGet.userMap['user']['profile_picture'] != null
                          ? Container(
                              width: ScreenUtil().setWidth(60),
                              height: ScreenUtil().setHeight(60),
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  shape: BoxShape.circle),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: appGet.userMap['user']
                                        ['profile_picture']),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              height: ScreenUtil().setWidth(60),
                              width: ScreenUtil().setWidth(60),
                              decoration: new BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                appGet.userMap['user']['name']
                                    .toString()[0]
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      SizedBox(
                        width: isPortrait
                            ? ScreenUtil().setWidth(8)
                            : ScreenUtil().setWidth(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appGet.userMap['user']['name'],
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: isPortrait
                                    ? ScreenUtil().setSp(16)
                                    : ScreenUtil().setSp(10)),
                          ),
                          SizedBox(
                            height: isPortrait
                                ? ScreenUtil().setHeight(10)
                                : ScreenUtil().setHeight(20),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: isPortrait
                                  ? ScreenUtil().setWidth(90)
                                  : ScreenUtil().setWidth(45),
                              height: isPortrait
                                  ? ScreenUtil().setHeight(21)
                                  : ScreenUtil().setHeight(42),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: HexColor('#E1E1E1')),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: isPortrait
                                        ? ScreenUtil().setWidth(6)
                                        : ScreenUtil().setWidth(5)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svgs/Shield Done.svg'),
                                    SizedBox(
                                      width: 70.w,
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        isExpanded: true,
                                        value: dropdownValue,
                                        //   icon: Icon(Icons.arrow_downward),
                                        //  iconSize: 24,
                                        elevation: 16,
                                        style:
                                            TextStyle(color: Colors.deepPurple),
                                        // underline: Container(
                                        //   height: 2,
                                        //   color: Colors.deepPurpleAccent,
                                        // ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>{
                                          'Public',
                                          // 'Private',
                                          // 'Friend'
                                        }.map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                images.length == 0
                    ? Expanded(
                        child: Container(
                          width: ScreenUtil().setWidth(326),
                          height: ScreenUtil().setHeight(82),
                          decoration: BoxDecoration(),
                          child: TextField(
                            controller: contentController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: isPortrait
                                    ? ScreenUtil().setHeight(15)
                                    : ScreenUtil().setHeight(10),
                                left: isPortrait
                                    ? ScreenUtil().setWidth(16)
                                    : ScreenUtil().setWidth(10),
                              ),
                              hintText: 'What\'s in your mind?',
                              hintStyle: TextStyle(
                                fontSize: isPortrait
                                    ? ScreenUtil().setSp(14)
                                    : ScreenUtil().setSp(8),
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : HexColor('#606060'),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: TextField(
                                controller: contentController,
                                maxLines: 2,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    top: isPortrait
                                        ? ScreenUtil().setHeight(15)
                                        : ScreenUtil().setHeight(10),
                                    left: isPortrait
                                        ? ScreenUtil().setWidth(16)
                                        : ScreenUtil().setWidth(10),
                                  ),
                                  hintText: 'What\'s in your mind?',
                                  hintStyle: TextStyle(
                                      fontSize: isPortrait
                                          ? ScreenUtil().setSp(14)
                                          : ScreenUtil().setSp(8),
                                      color: HexColor('#606060')),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.w,
                                        mainAxisSpacing: 5.h),
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return AssetThumb(
                                    asset: images[index],
                                    height: 300,
                                    width: 300,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  onTap: () {
                    loadAssets();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: isPortrait
                            ? ScreenUtil().setWidth(26)
                            : ScreenUtil().setWidth(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/svgs/image.svg'),
                        SizedBox(
                          width: isPortrait
                              ? ScreenUtil().setWidth(10)
                              : ScreenUtil().setWidth(10),
                        ),
                        Text(
                          'Photo/Video',
                          style: TextStyle(
                            fontSize: isPortrait
                                ? ScreenUtil().setSp(14)
                                : ScreenUtil().setSp(8),
                            color: Get.isDarkMode
                                ? Colors.white
                                : HexColor('#3A3A3A'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: isPortrait
                      ? ScreenUtil().setHeight(12)
                      : ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: isPortrait
                        ? ScreenUtil().setWidth(22)
                        : ScreenUtil().setWidth(14),
                    left: isPortrait
                        ? ScreenUtil().setWidth(22)
                        : ScreenUtil().setWidth(14),
                  ),
                  child: Container(
                    color: HexColor('#D4D4D4'),
                    width: isPortrait
                        ? ScreenUtil().setWidth(353)
                        : ScreenUtil().setWidth(353),
                    height: isPortrait
                        ? ScreenUtil().setHeight(1)
                        : ScreenUtil().setHeight(1),
                  ),
                ),
                SizedBox(
                  height: isPortrait
                      ? ScreenUtil().setHeight(12)
                      : ScreenUtil().setHeight(18),
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: isPortrait
                //             ? ScreenUtil().setWidth(26)
                //             : ScreenUtil().setWidth(18)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         SvgPicture.asset('assets/svgs/profile.svg'),
                //         SizedBox(
                //           width: isPortrait
                //               ? ScreenUtil().setWidth(10)
                //               : ScreenUtil().setWidth(10),
                //         ),
                //         Text(
                //           'Tag Friends',
                //           style: TextStyle(
                //               fontSize: isPortrait
                //                   ? ScreenUtil().setSp(14)
                //                   : ScreenUtil().setSp(8),
                //               color: HexColor('#3A3A3A')),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(12)
                //       : ScreenUtil().setHeight(20),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     right: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //     left: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //   ),
                //   child: Container(
                //     color: HexColor('#D4D4D4'),
                //     width: isPortrait
                //         ? ScreenUtil().setWidth(353)
                //         : ScreenUtil().setWidth(353),
                //     height: isPortrait
                //         ? ScreenUtil().setHeight(1)
                //         : ScreenUtil().setHeight(1),
                //   ),
                // ),
                // SizedBox(
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(12)
                //       : ScreenUtil().setHeight(18),
                // ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: isPortrait
                //             ? ScreenUtil().setWidth(26)
                //             : ScreenUtil().setWidth(18)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         SvgPicture.asset('assets/svgs/video.svg'),
                //         SizedBox(
                //           width: isPortrait
                //               ? ScreenUtil().setWidth(10)
                //               : ScreenUtil().setWidth(10),
                //         ),
                //         Text(
                //           'Live Camera',
                //           style: TextStyle(
                //               fontSize: isPortrait
                //                   ? ScreenUtil().setSp(14)
                //                   : ScreenUtil().setSp(8),
                //               color: HexColor('#3A3A3A')),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(12)
                //       : ScreenUtil().setHeight(20),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     right: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //     left: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //   ),
                //   child: Container(
                //     color: HexColor('#D4D4D4'),
                //     width: isPortrait
                //         ? ScreenUtil().setWidth(353)
                //         : ScreenUtil().setWidth(353),
                //     height: isPortrait
                //         ? ScreenUtil().setHeight(1)
                //         : ScreenUtil().setHeight(1),
                //   ),
                // ),
                // SizedBox(
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(12)
                //       : ScreenUtil().setHeight(18),
                // ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: isPortrait
                //             ? ScreenUtil().setWidth(26)
                //             : ScreenUtil().setWidth(18)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         SvgPicture.asset('assets/svgs/Location.svg'),
                //         SizedBox(
                //           width: isPortrait
                //               ? ScreenUtil().setWidth(16)
                //               : ScreenUtil().setWidth(14),
                //         ),
                //         Text(
                //           'Location',
                //           style: TextStyle(
                //               fontSize: isPortrait
                //                   ? ScreenUtil().setSp(14)
                //                   : ScreenUtil().setSp(8),
                //               color: HexColor('#3A3A3A')),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(12)
                //       : ScreenUtil().setHeight(20),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     right: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //     left: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //   ),
                //   child: Container(
                //     color: HexColor('#D4D4D4'),
                //     width: isPortrait
                //         ? ScreenUtil().setWidth(353)
                //         : ScreenUtil().setWidth(353),
                //     height: isPortrait
                //         ? ScreenUtil().setHeight(1)
                //         : ScreenUtil().setHeight(1),
                //   ),
                // ),
                // SizedBox(
                //   height: isPortrait
                //       ? ScreenUtil().setHeight(12)
                //       : ScreenUtil().setHeight(18),
                // ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //         left: isPortrait
                //             ? ScreenUtil().setWidth(26)
                //             : ScreenUtil().setWidth(18)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         SvgPicture.asset('assets/svgs/smile.svg'),
                //         SizedBox(
                //           width: isPortrait
                //               ? ScreenUtil().setWidth(16)
                //               : ScreenUtil().setWidth(14),
                //         ),
                //         Text(
                //           'Feeling',
                //           style: TextStyle(
                //               fontSize: isPortrait
                //                   ? ScreenUtil().setSp(14)
                //                   : ScreenUtil().setSp(8),
                //               color: HexColor('#3A3A3A')),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: isPortrait
                      ? ScreenUtil().setHeight(12)
                      : ScreenUtil().setHeight(20),
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     right: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //     left: isPortrait
                //         ? ScreenUtil().setWidth(22)
                //         : ScreenUtil().setWidth(14),
                //   ),
                //   child: Container(
                //     color: HexColor('#D4D4D4'),
                //     width: isPortrait
                //         ? ScreenUtil().setWidth(353)
                //         : ScreenUtil().setWidth(353),
                //     height: isPortrait
                //         ? ScreenUtil().setHeight(1)
                //         : ScreenUtil().setHeight(1),
                //   ),
                // ),
                SizedBox(
                  height: isPortrait
                      ? ScreenUtil().setHeight(23)
                      : ScreenUtil().setHeight(23),
                ),
              ],
            ),
    );
  }
}
