import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Addcomments extends StatefulWidget {
  final int postid;
  Addcomments(this.postid, {Key key}) : super(key: key);

  @override
  _AddcommentsState createState() => _AddcommentsState();
}

class _AddcommentsState extends State<Addcomments> {
  AppGet appGet = Get.find();

  TextEditingController commentcontroller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //  appGet.commntFocusNode    = FocusNode();
  }
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed.
  //    appGet.commntFocusNode.dispose();

  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          height: 40.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: Color(0xffB8B7B7))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('Add comment..'),
                // child: TextField(
                //   // focusNode: appGet.commntFocusNode,
                //   textInputAction: TextInputAction.done,
                //   textAlign: TextAlign.left,
                //   onSubmitted: (value) {
                //     print('add comment');
                //     createComment(
                //         widget.postid, commentcontroller.text, null, null);
                //     commentcontroller.text = '';
                //   },
                //   controller: commentcontroller,
                //   keyboardType: TextInputType.text,
                //   decoration: InputDecoration(
                //     fillColor: Colors.white,
                //     // filled: true,
                //     border: InputBorder.none,
                //     focusedBorder: InputBorder.none,
                //     hintText: 'Add comment..',
                //     hintStyle: TextStyle(fontSize: 16),
                //     contentPadding: EdgeInsets.only(top: 0, left: 10),
                //   ),
                // ),
              ),
            ],
          )),
    );
  }
}
