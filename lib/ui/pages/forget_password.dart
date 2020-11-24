import 'package:bbmsg_mobile/services/connectvity_service.dart';
import 'package:bbmsg_mobile/ui/widgets/TextField.dart';
import 'package:bbmsg_mobile/ui/widgets/primary_button.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  String userName;

  String password;

  saveUserName(String value) {
    print(value);
    this.userName = value;
  }

  savePassword(String password) {
    this.password = password;
  }

  saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 30.w),
            child: Column(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(300),
                  child: SvgPicture.asset('assets/svgs/forget_password.svg',
                      semanticsLabel: 'Acme Logo'),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  translator.translate('Forget Password'),
                  style: Styles.titleTextStyle
                      .copyWith(fontSize: 30, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
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
                                hintTextKey: 'Email/Mobile',
                                inputType: TextInputType.text,
                                iconData: Icons.account_circle,
                                validateFunction: validatepasswordFunction,
                                saveFunction: saveUserName,
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
                      Container(
                        width: double.infinity,
                        child: PrimaryButton(
                          color: primaryColor,
                          textColor: Colors.white,
                          buttonPressFun: saveForm,
                          textKey: 'Send',
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
    );
  }
}
