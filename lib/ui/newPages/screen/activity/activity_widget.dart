import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/utils/data_formatter.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class ActivityWidget extends StatelessWidget {
  Map activityMap;
  ActivityWidget(this.activityMap);
  Widget buildWidget(Map map) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              map['author']['profile_picture'] != null
                  ? Container(
                      height: ScreenUtil().setWidth(40),
                      width: ScreenUtil().setWidth(40),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              map['author']['profile_picture'].toString(),
                            )),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setWidth(40),
                      width: ScreenUtil().setWidth(40),
                      decoration: new BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        map['author']['name'].toString()[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          map['type'] == 'follow'
                              ? Row(
                                  children: [
                                    Text(
                                        '${map['author']['name'][0].toString().toUpperCase()}${map['author']['name'].toString().substring(1)}',
                                        style: TextStyle(
                                            fontFamily: 'second_header',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16)),
                                    Text(' start following you'),
                                  ],
                                )
                              : Text(
                                  '${map['author']['name'][0].toString().toUpperCase()}${map['author']['name'].toString().substring(1)}',
                                  style: TextStyle(
                                      fontFamily: 'second_header',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                          Text(
                              '${DateFormat.jm().format(DateTime.parse(map['created_at']))}')
                        ],
                      ),
                    ),
                    map['type'] == 'comment'
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Commented on your post'),
                                Text(
                                  map['comment']['content'],
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          )
                        : map['type'] == 'like'
                            ? Text('liked your post')
                            : Text('')
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: activityMap['data'].length,
          itemBuilder: (context, index) {
            Map map = activityMap['data'][index];
            DateTime dateTime = DateTime.parse(map['created_at']);
            return Column(
              children: [buildWidget(map)],
            );
          },
        )
      ],
    );
  }
}
