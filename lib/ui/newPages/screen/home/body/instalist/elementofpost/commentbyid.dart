import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/listpostcomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Commentbyid extends StatefulWidget {
  final int commentidindex;
  final int numofcomment;
  Commentbyid(this.commentidindex, this.numofcomment, {Key key})
      : super(key: key);

  @override
  _CommentbyidState createState() => _CommentbyidState();
}

class _CommentbyidState extends State<Commentbyid> {
  NeverScrollableScrollPhysics noscroll = new NeverScrollableScrollPhysics();
  AppGet appGet = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);

    return FutureBuilder(
      initialData: null,
      future: getAcomment(widget.commentidindex),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.data == null || snapshot.data['total'] == 0
            ? Container(
                child: Text(''),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    width: 300.w,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            snapshot.data['data'][0]['author']['name']
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Flexible(
                            child: Text(
                          snapshot.data['data'][0]['content'].toString(),
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                  //
                  SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: widget.numofcomment == 0 ? false : true,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(Listcommentpost(widget.commentidindex));
                      },
                      child: Flexible(
                        child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              'View all ' +
                                  (widget.numofcomment > 0
                                          ? widget.numofcomment - 1
                                          : '0')
                                      .toString() +
                                  ' comments',
                              overflow: TextOverflow.ellipsis,
                            )),
                      ),
                    ),
                  )
                ],
              );
      },
    );
  }
}
