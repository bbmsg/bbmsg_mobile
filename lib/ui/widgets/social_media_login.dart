import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SocialMediaLogin extends StatelessWidget {
  Function facebookLoginFun;
  Function gmailLoginFun;
  Function twitterLoginFun;
  SocialMediaLogin(
      {this.facebookLoginFun, this.gmailLoginFun, this.twitterLoginFun});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            this.facebookLoginFun();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SvgPicture.asset('assets/svgs/facebook.svg',
                height: 40.h, width: 40.w, semanticsLabel: 'facebook login'),
          ),
        ),
        GestureDetector(
          onTap: () {
            this.gmailLoginFun();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SvgPicture.asset('assets/svgs/google.svg',
                height: 40.h, width: 40.w, semanticsLabel: 'facebook login'),
          ),
        ),
        GestureDetector(
          onTap: () {
            this.twitterLoginFun();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SvgPicture.asset('assets/svgs/twitter.svg',
                height: 40.h, width: 40.w, semanticsLabel: 'facebook login'),
          ),
        )
      ],
    );
  }
}
