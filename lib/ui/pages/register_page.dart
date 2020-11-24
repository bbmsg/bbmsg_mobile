import 'package:auto_size_text/auto_size_text.dart';
import 'package:bbmsg_mobile/services/connectvity_service.dart';
import 'package:bbmsg_mobile/ui/widgets/TextField.dart';
import 'package:bbmsg_mobile/ui/widgets/primary_button.dart';
import 'package:bbmsg_mobile/ui/widgets/social_media_login.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String userName;
  String email;
  String password;
  String password2;
  saveUserName(String value) {
    this.userName = value;
  }

  saveEmail(String value) {
    this.email = value;
  }

  savePassword1(String value) {
    this.password = value;
  }

  savePasword2(String value) {
    this.password2 = value;
  }

  validateNullFunction(val) {
    if (val.isEmpty) {
      return translator.translate("null_error");
    }
    return null;
  }

  validateEmailFunction(val) {
    if (val.isEmpty) {
      return translator.translate("null_error");
    }
    return null;
  }

  validatepasswordFunction(String value) {
    if (value.isEmpty) {
      return translator.translate('null_error');
    } else if (value.length < 6) {
      return translator.translate('password_error');
    }
  }

  saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
      } else {}
    }
  }

  forgetPassword() {}

  createNewAccount() {}

  facebookLogin() {}

  gmailLogin() {}

  twiterLogin() {}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          child: Scaffold(
            key: scaffoldKey,
            // backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'assets/pngs/logo.png',
                    height: 150.h,
                    color: primaryColor,
                  ),
                  Text(
                    translator.translate('Sign up'),
                    style: Styles.titleTextStyle
                        .copyWith(fontSize: 30, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Form(
                          key: formKey,
                          child: Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Column(
                              children: <Widget>[
                                MyTextField(
                                  svgAsset: 'assets/svgs/user_icon.svg',
                                  borderColor: primaryColor,
                                  hintTextKey: 'User Name',
                                  inputType: TextInputType.text,
                                  iconData: Icons.account_circle,
                                  validateFunction: validateNullFunction,
                                  saveFunction: saveUserName,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                MyTextField(
                                  svgAsset: 'assets/svgs/user_icon.svg',
                                  borderColor: primaryColor,
                                  hintTextKey: 'Email/Mobile',
                                  inputType: TextInputType.text,
                                  iconData: Icons.account_circle,
                                  validateFunction: validateEmailFunction,
                                  saveFunction: saveEmail,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                MyTextField(
                                  svgAsset: 'assets/svgs/password_icon.svg',
                                  borderColor: primaryColor,
                                  hintTextKey: 'Password',
                                  iconData: Icons.lock,
                                  validateFunction: validatepasswordFunction,
                                  saveFunction: savePassword1,
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                MyTextField(
                                  svgAsset: 'assets/svgs/password_icon.svg',
                                  borderColor: primaryColor,
                                  hintTextKey: 'Confirm Password',
                                  iconData: Icons.lock,
                                  validateFunction: validatepasswordFunction,
                                  saveFunction: savePasword2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            forgetPassword();
                          },
                          child: AutoSizeText(
                            translator.translate(
                                'By clicking on sign up you agree on Terms & Conditions '),
                            style: TextStyle(color: primaryColor, fontSize: 17),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: PrimaryButton(
                            color: primaryColor,
                            textColor: Colors.white,
                            buttonPressFun: saveForm,
                            textKey: 'Sign up',
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Divider()),
                            Text(
                              translator.translate('OR'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SocialMediaLogin(
                          facebookLoginFun: this.facebookLogin,
                          gmailLoginFun: this.gmailLogin,
                          twitterLoginFun: this.twiterLogin,
                        ),
                        GestureDetector(
                          onTap: () {
                            forgetPassword();
                          },
                          child: Text(
                            translator
                                .translate('Already have account? Sign in'),
                            style: TextStyle(
                                color: Color(0xFF717171), fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
