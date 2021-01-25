import 'package:bbmsg_mobile/ui/newPages/screen/search/trends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import 'explorere.dart';

class Searchscr extends StatefulWidget {
  Searchscr({Key key}) : super(key: key);

  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Searchscr> {
  List img = [
    'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
    'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png',
    'https://homepages.cae.wisc.edu/~ece533/images/baboon.png',
    'https://homepages.cae.wisc.edu/~ece533/images/barbara.png',
    'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
    'https://homepages.cae.wisc.edu/~ece533/images/frymire.png',
    'https://homepages.cae.wisc.edu/~ece533/images/monarch.png',
    'https://homepages.cae.wisc.edu/~ece533/images/pool.png',
    'https://homepages.cae.wisc.edu/~ece533/images/tulips.png',
    'https://homepages.cae.wisc.edu/~ece533/images/watch.png'
    // 'assets/images/1.jpg',
    // 'assets/images/2.jpg',
    // 'assets/images/3.jpg',
    // 'assets/images/4.jpg',
    // 'assets/images/5.jpg',
    // 'assets/images/6.jpg',
    // 'assets/images/7.jpg',
    // 'assets/images/8.jpg',
    // 'assets/images/9.jpg',
    // 'assets/images/10.jpg',
    // 'assets/images/11.jpg',
    // 'assets/images/12.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Image.asset('assets/pngs/UnderConstruction.png'),
    ));
  }
}
