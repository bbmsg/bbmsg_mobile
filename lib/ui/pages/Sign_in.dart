import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/connectvity_service.dart';
import 'package:bbmsg_mobile/ui/widgets/TextField.dart';
import 'package:bbmsg_mobile/ui/widgets/primary_button.dart';
import 'package:bbmsg_mobile/ui/widgets/social_media_login.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String credintial;
  String password;
  saveMobikeNumber(String value) {
    print(value);
    this.credintial = value;
  }

  savePassword(String password) {
    this.password = password;
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
      // if (ConnectivityService.connectivityStatus !=
      //     ConnectivityStatus.Offline) {

      getUserToken(
          credintial: credintial, password: password, strategy: 'local');
      // } else {}
    }
  }

  forgetPassword() {}

  createNewAccount() {}

  facebookLogin() {
    signInWithFacebook();
  }

  gmailLogin() {
    signInWithGoogle();
  }

  twiterLogin() {
    // signInWithTwitter();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Scaffold(
            key: scaffoldKey,
            // backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/pngs/logo.png',
                      height: 160.h,
                      color: primaryColor,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      translator.translate('Sign in'),
                      style: Styles.titleTextStyle
                          .copyWith(fontSize: 30, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Column(
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
                                  hintTextKey: 'Email/Mobile',
                                  inputType: TextInputType.text,
                                  iconData: Icons.account_circle,
                                  validateFunction: validatepasswordFunction,
                                  saveFunction: saveMobikeNumber,
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
                                  saveFunction: savePassword,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Container(
                          width: double.infinity,
                          child: PrimaryButton(
                            color: primaryColor,
                            textColor: Colors.white,
                            buttonPressFun: saveForm,
                            textKey: 'Login',
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            forgetPassword();
                          },
                          child: Text(
                            translator.translate('Forget Password'),
                            style: TextStyle(
                                color: Color(0xFF717171), fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        SocialMediaLogin(
                          facebookLoginFun: this.facebookLogin,
                          gmailLoginFun: this.gmailLogin,
                          twitterLoginFun: this.twiterLogin,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            forgetPassword();
                          },
                          child: Text(
                            translator
                                .translate('Don’t have an Account? Signup'),
                            style: TextStyle(
                                color: Color(0xFF717171), fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
