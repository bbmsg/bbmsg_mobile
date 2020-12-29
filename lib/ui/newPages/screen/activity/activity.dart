import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/activity/activity_widget.dart';
import 'package:bbmsg_mobile/utils/data_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ActivityPage extends StatelessWidget {
  // Map activityMap0 = {
  //   "total": 5,
  //   "limit": 10,
  //   "skip": 0,
  //   "data": [
  //     {
  //       "date": "28/12/2020",
  //       "data": [
  //         {
  //           "id": 4,
  //           "type": "comment",
  //           "created_at": "2020-12-29T13:31:55.244Z",
  //           "updated_at": "2020-12-29T13:31:55.244Z",
  //           "author": {"id": 14, "name": "farah", "profile_picture": null},
  //           "post": {"id": 21, "content": "السلام عليكم"},
  //           "comment": {"id": 8, "content": "يا ‏سلام ‏عليك"}
  //         },
  //         {
  //           "id": 5,
  //           "type": "follow",
  //           "created_at": "2020-12-29T13:33:09.572Z",
  //           "updated_at": "2020-12-29T13:33:09.572Z",
  //           "author": {"id": 14, "name": "farah", "profile_picture": null}
  //         },
  //         {
  //           "id": 6,
  //           "type": "like",
  //           "created_at": "2020-12-29T13:34:38.096Z",
  //           "updated_at": "2020-12-29T13:34:38.096Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null}
  //         },
  //       ]
  //     },
  //     {
  //       "date": "27/12/2020",
  //       "data": [
  //         {
  //           "id": 3,
  //           "type": "like",
  //           "created_at": "2020-12-28T13:31:44.453Z",
  //           "updated_at": "2020-12-28T13:31:44.453Z",
  //           "author": {"id": 14, "name": "farah", "profile_picture": null}
  //         },
  //         {
  //           "id": 4,
  //           "type": "comment",
  //           "created_at": "2020-12-28T13:31:55.244Z",
  //           "updated_at": "2020-12-28T13:31:55.244Z",
  //           "author": {"id": 14, "name": "farah", "profile_picture": null},
  //           "post": {"id": 21, "content": "السلام عليكم"},
  //           "comment": {"id": 8, "content": "يا ‏سلام ‏عليك"}
  //         },
  //         {
  //           "id": 5,
  //           "type": "follow",
  //           "created_at": "2020-12-28T13:33:09.572Z",
  //           "updated_at": "2020-12-28T13:33:09.572Z",
  //           "author": {"id": 14, "name": "farah", "profile_picture": null}
  //         },
  //         {
  //           "id": 6,
  //           "type": "like",
  //           "created_at": "2020-12-28T13:34:38.096Z",
  //           "updated_at": "2020-12-28T13:34:38.096Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null}
  //         },
  //         {
  //           "id": 7,
  //           "type": "comment",
  //           "created_at": "2020-12-28T13:34:48.842Z",
  //           "updated_at": "2020-12-28T13:34:48.842Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null},
  //           "post": {"id": 21, "content": "السلام عليكم"},
  //           "comment": {"id": 9, "content": "تمام ‏يا ‏بطل"}
  //         }
  //       ]
  //     },
  //     {
  //       "date": "25/12/2020",
  //       "data": [
  //         {
  //           "id": 6,
  //           "type": "like",
  //           "created_at": "2020-12-27T13:34:38.096Z",
  //           "updated_at": "2020-12-27T13:34:38.096Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null}
  //         },
  //         {
  //           "id": 7,
  //           "type": "comment",
  //           "created_at": "2020-12-27T13:34:48.842Z",
  //           "updated_at": "2020-12-27T13:34:48.842Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null},
  //           "post": {"id": 21, "content": "السلام عليكم"},
  //           "comment": {"id": 9, "content": "تمام ‏يا ‏بطل"}
  //         }
  //       ]
  //     },
  //     {
  //       "date": "22/12/2020",
  //       "data": [
  //         {
  //           "id": 6,
  //           "type": "like",
  //           "created_at": "2020-12-26T13:34:38.096Z",
  //           "updated_at": "2020-12-26T13:34:38.096Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null}
  //         },
  //         {
  //           "id": 7,
  //           "type": "comment",
  //           "created_at": "2020-12-26T13:34:48.842Z",
  //           "updated_at": "2020-12-26T13:34:48.842Z",
  //           "author": {"id": 15, "name": "afnan", "profile_picture": null},
  //           "post": {"id": 21, "content": "السلام عليكم"},
  //           "comment": {"id": 9, "content": "تمام ‏يا ‏بطل"}
  //         }
  //       ]
  //     }
  //   ]
  // };
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Obx(() {
      return appGet.mapActivity.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) {
                return Container(padding: EdgeInsets.symmetric(vertical: 10));
              },
              itemCount: appGet.mapActivity['data'].length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                          DateFormatter.getVerboseDateTimeRepresentation(
                              appGet.mapActivity['data'][index]['data'][0]
                                  ['created_at']),
                          style: TextStyle(
                              fontFamily: 'second_header',
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child:
                            ActivityWidget(appGet.mapActivity['data'][index])),
                  ],
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            );
    }));
  }
}
