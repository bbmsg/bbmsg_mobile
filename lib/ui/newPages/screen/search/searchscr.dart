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
    ScreenUtil.init(context,
        designSize: Size(375, 812), allowFontScaling: false);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new SizedBox(
            width: ScreenUtil().setWidth(339),
            height: ScreenUtil().setHeight(45),
            child: Padding(
                padding: EdgeInsets.only(top: 0, left: 10, right: 10),
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0, color: Colors.grey[200])),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.left,

                          // controller: searchCtrl,

                          keyboardType: TextInputType.text,

                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(Icons.mic_none), onPressed: () {}),

                            prefixIcon: IconButton(
                                icon: Icon(FontAwesomeIcons.slidersH),
                                onPressed: () {}),

                            hintText: 'Search',

                            hintStyle: TextStyle(fontSize: 16),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.white,

                                //   //     width: 0,

                                // style: BorderStyle.none,
                              ),
                            ),

                            // filled: true,

                            contentPadding: EdgeInsets.only(top: 0, left: 10),

                            // fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Trends',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(16), color: HexColor('#00ADEE')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Explore',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(16), color: HexColor('#00ADEE')),
            ),
          ),
          Container(
              height: ScreenUtil().setHeight(21),
              // width: ScreenUtil().setWidth(84),
              child: Trendeslist()),
          Expanded(child: Explorers(img))
          // Toollist(),
        ],
      ),
    );
  }
}
