import 'package:bbmsg_mobile/ui/pages/Sign_in.dart';
import 'package:bbmsg_mobile/ui/pages/forget_password.dart';
import 'package:bbmsg_mobile/ui/pages/register_page.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/radii.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MiddlePage(),
    );
  }
}

class MiddlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(392.72727272727275, 850.9090909090909),
        allowFontScaling: true);
    return RegisterPage();
  }
}

class MainPage extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8);
  List svgs = ['assets/svgs/'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(30),
              horizontal: ScreenUtil().setHeight(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(300),
                    child: PageView.builder(
                      controller: controller,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return SvgPicture.asset(
                            'assets/svgs/app_feature${index + 1}.svg',
                            semanticsLabel: 'Acme Logo');
                      },
                    ),
                  ),
                  Container(
                      child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: WormEffect(dotHeight: 10, dotWidth: 10),
                  )),
                  SizedBox(height: 16),
                  Container(
                      child: Text(
                    'BBmsg Social Network',
                    style: Styles.titleTextStyle,
                  )),
                  Container(
                      child: Text(
                    '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. ''',
                    style: Styles.secondTitleTextStyle,
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
              Container(
                child: Text(
                  'Sign in or create a new account',
                  style: TextStyle(
                      fontFamily: 'second_header',
                      color: primaryColor,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setHeight(15)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(15)),
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(20)),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontFamily: 'second_header',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          color: primaryColor, borderRadius: Radii.k8pxRadius),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(15)),
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(20)),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: 'second_header',
                            color: primaryColor,
                            fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          color: Colors.white,
                          borderRadius: Radii.k8pxRadius),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
