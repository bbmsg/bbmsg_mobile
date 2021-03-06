import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/body/instalist/elementofpost/listpostcomment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:bbmsg_mobile/ui/newPages/createpost.dart';

class PostLikeAndCommentWidget extends StatelessWidget {
  int index;
  PostLikeAndCommentWidget(this.index);
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return GetBuilder<AppGet>(
        init: AppGet(), // INIT IT ONLY THE FIRST TIME
        builder: (x) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 28,
                      icon: x.posts[index]['my_like'] == 0
                          ? SvgPicture.asset('assets/svgs/fav.svg',
                              width: 20,
                              height: 20,
                              color: _darkTheme ? Colors.white : Colors.grey)
                          : Icon(Icons.favorite),
                      color: x.posts[index]['my_like'] == 0
                          ? Colors.grey
                          : Colors.red,
                      onPressed: () {
                        x.posts[index]['my_like'] == 0
                            ? like(x.posts[index]['id'], index)
                            : removelike(x.posts[index]['my_like'], index);
                      },
                    ),
                    // Text(x.posts[index]['likes'].toString()),
                    SizedBox(
                      width: ScreenUtil().setWidth(4.w),
                    ),

                    GestureDetector(
                      onTap: () {
                        getAcommentlist(appGet.posts[index]['id']);
                        Get.to(PostDetailsa(
                          index,
                        ));
                      },
                      child: SvgPicture.asset('assets/svgs/chat.svg',
                          width: 20,
                          color: _darkTheme ? Colors.white : Colors.grey),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(4.w),
                    ),
                    // Text(
                    //   appGet.posts[index]['comments'].toString(),
                    // ),
                    IconButton(
                      icon: SvgPicture.asset('assets/svgs/share.svg',
                          width: 20,
                          color: _darkTheme ? Colors.white : Colors.grey),
                      onPressed: () {
                        print('idddd ${appGet.posts[index]['id'].toString()}');
                        Get.to(
                          Createpostscr(
                            true,
                            postId: appGet.posts[index]['id'].toString(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Divider(),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15.h,
                    ),
                    Icon(
                      Icons.favorite,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8.h,
                    ),
                    Text(
                      '${appGet.posts[index]['likes'].toString()} likes',
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
