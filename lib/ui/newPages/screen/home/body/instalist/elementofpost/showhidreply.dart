import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/listreplycomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class Shohidreply extends StatefulWidget {
  final int commentid;
  final int replycount;
  Shohidreply(this.commentid, this.replycount, {Key key}) : super(key: key);

  @override
  _ShohidreplyState createState() => _ShohidreplyState();
}

class _ShohidreplyState extends State<Shohidreply> {
  bool shoreplyorhid = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.replycount == 0 ? false : true,
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 90.w,
                  ),
                  Container(
                    width: 30.w,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        shoreplyorhid = !shoreplyorhid;
                      });
                    },
                    child: Container(
                      width: 80.w,

                      height: 30.h,

                      // color: Colors.grey,

                      child: Center(
                          child: shoreplyorhid
                              ? Text(
                                  'Hide replies',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12),
                                )
                              : Text(
                                  'View ' +
                                      widget.replycount.toString() +
                                      ' replies',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 12),
                                )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      Visibility(
        visible: shoreplyorhid,
        child: Listrplaycomment(widget.commentid))
            
      ],
    );
  }
}
