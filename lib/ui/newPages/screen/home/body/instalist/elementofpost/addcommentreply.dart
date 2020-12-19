import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Addcommentsreply extends StatefulWidget {
  final int postid;
  final int commintorpost;
  Addcommentsreply(this.postid, this.commintorpost, {Key key})
      : super(key: key);

  @override
  _AddcommentsreplyState createState() => _AddcommentsreplyState();
}

class _AddcommentsreplyState extends State<Addcommentsreply> {
  AppGet appGet = Get.find();

  TextEditingController commentcontroller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    appGet.commntFocusNode2 = FocusNode();
  }

  void dispose() {
    // Clean up the focus node when the Form is disposed.
    appGet.commntFocusNode2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.h,
        child: Center(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 2, color: Colors.blue)),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  focusNode: appGet.commntFocusNode2,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.left,
                  onSubmitted: (value) {
                    print('appGet.commentorreply' +
                        appGet.commentorreply.toString());
                    if (appGet.commentorreply == 1) {
                      print('add comment');
                      createComment(
                          widget.postid, commentcontroller.text, null, null);
                      commentcontroller.text = '';
                    } else {
                      print('add replay');
                      createreplay(
                          appGet.replyid, commentcontroller.text, null, null);
                    }
                    ;
                  },
                  controller: commentcontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    // filled: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Add comment..',
                    hintStyle: TextStyle(fontSize: 16),
                    contentPadding: EdgeInsets.only(top: 0, left: 10),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 25.w,
                    child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: null),
                  ),
                  Container(
                    width: 27.w,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 14.h,
                            left: 7.w,
                            child: Container(
                              width: 20.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            )),
                        Positioned(
                            child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.solidSmile,
                                  color: Colors.yellow[600],
                                ),
                                onPressed: null))
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.plusSquare,
                          size: 20,
                        ),
                        onPressed: null),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
