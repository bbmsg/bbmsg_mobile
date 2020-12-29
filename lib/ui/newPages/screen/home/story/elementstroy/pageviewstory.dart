import 'package:flutter/material.dart';
import 'package:bbmsg_mobile/ui/newPages/screen/home/story/elementstroy/photostoryshow.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:get/get.dart';

class Pageviewstory extends StatefulWidget {
  final List listall;
  final int pagini;
  Pageviewstory(this.listall, this.pagini, {Key key}) : super(key: key);

  @override
  _PageviewstoryState createState() => _PageviewstoryState();
}

class _PageviewstoryState extends State<Pageviewstory> {
  int _currentPage = 0;
  AppGet appGet = Get.find();
  final pagcontroller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pagcontroller,
        onPageChanged: (value) {
          if (appGet.completcycle == true.obs) {
            _currentPage++;
            pagcontroller.animateToPage(
              _currentPage,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeIn,
            );
          }
        },
        children: [
          for (var i = 0; i < widget.listall.length; i++)
            PhotoStoryshow('tt', widget.listall[i]['stories'])
        ],
      ),
    );
  }
}
