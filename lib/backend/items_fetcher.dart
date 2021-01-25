import 'dart:math';

import 'package:bbmsg_mobile/backend/server.dart';

class ItemFetcher {
  int count;
  int itemsPerPage;
  int currentPage = 1;
  ItemFetcher({this.count, this.itemsPerPage});

  // This async function simulates fetching results from Internet, etc.
  Future<List> fetch() async {
    final list = [];
    final n = min(itemsPerPage, count - currentPage * itemsPerPage);
    // Uncomment the following line to see in real time now items are loaded lazily.
    // print('Now on page $_currentPage');
    await Future.delayed(Duration(seconds: 1), () {
      logger.e('limit is $n');
      logger.e('skips is ${currentPage * itemsPerPage}');
      getPosts(limit: n, skip: currentPage * itemsPerPage);
    });
    currentPage++;
    return list;
  }
}
