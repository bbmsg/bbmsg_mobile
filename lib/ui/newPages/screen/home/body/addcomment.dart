import 'package:bbmsg_mobile/backend/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Addcomments extends StatefulWidget {
  final int postid;
  Addcomments(this.postid, {Key key}) : super(key: key);

  @override
  _AddcommentsState createState() => _AddcommentsState();
}

class _AddcommentsState extends State<Addcomments> {
  TextEditingController commentcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.left,
                    onSubmitted: (value) {
                      print('add comment');
                      createComment(
                          widget.postid, commentcontroller.text, null, null);
                      commentcontroller.text = '';
                    },
                    controller: commentcontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      // suffixIcon: Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     SizedBox(
                      //       width: 25.w,
                      //       child: IconButton(
                      //           icon: Icon(
                      //             Icons.favorite,
                      //             color: Colors.red,
                      //           ),
                      //           onPressed: null),
                      //     ),
                      //     Container(
                      //       width: 27.w,
                      //       child: Stack(
                      //         children: [
                      //           Positioned(
                      //               top: 14.h,
                      //               left: 7.w,
                      //               child: Container(
                      //                 width: 20.w,
                      //                 height: 20.h,
                      //                 decoration: BoxDecoration(
                      //                     shape: BoxShape.circle,
                      //                     color: Colors.black),
                      //               )),
                      //           Positioned(
                      //               child: IconButton(
                      //                   icon: Icon(
                      //                     FontAwesomeIcons.solidSmile,
                      //                     color: Colors.yellow[600],
                      //                   ),
                      //                   onPressed: null))
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 30.w,
                      //       child: IconButton(
                      //           icon: Icon(
                      //             FontAwesomeIcons.plusSquare,
                      //             size: 20,
                      //           ),
                      //           onPressed: null),
                      //     ),
                      //   ],
                      // ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Add comment..',

                      hintStyle: TextStyle(fontSize: 16),
                      // border: OutlineInputBorder(
                      //   // borderRadius: BorderRadius.circular(16),
                      //   borderSide: BorderSide(
                      //     // color: Colors.white,
                      //     //   //     width: 0,
                      //     style: BorderStyle.none,
                      //   ),
                      // ),
                      // filled: true,
                      contentPadding: EdgeInsets.only(top: 0, left: 10),
                      // fillColor: Colors.grey[200],
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
                                    shape: BoxShape.circle,
                                    color: Colors.black),
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
          ))),
    );
  }
}
