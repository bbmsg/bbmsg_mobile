import 'package:bbmsg_mobile/Splash.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/ui/widgets/custom_appbar.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/radii.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  List<bool> isSelected = [true, false];
  String c = 'nasser';
  AppGet appGet = Get.find();
  setIsSelectedList() async {
    String lang = await SPHelper.spHelper.getLanguage();

    if (lang == 'ar') {
      setState(() {
        isSelected = [true, false];
      });
    } else {
      setState(() {
        isSelected = [false, true];
      });
    }
  }

  @override
  void initState() {
    // isSelected = [true, false];
    setIsSelectedList();
    super.initState();
  }

  bool isDark = Get.isDarkMode;
  bool isFingerprint = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar('Settings'),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 25.h),
          child: ListView(
            children: [
              ListTile(
                leading: Image.asset(
                  'assets/pngs/language.png',
                ),
                title: Text(translator.translate('language')),
                trailing: Container(
                  height: 45.h,
                  child: ToggleButtons(
                    borderColor: primaryColor,
                    fillColor: primaryColor,
                    borderWidth: 2,
                    selectedBorderColor: primaryColor,
                    selectedColor: Colors.white,
                    borderRadius: Radii.k8pxRadius,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          translator.translate('arabic'),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          translator.translate('english'),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      if (index == 0) {
                        SPHelper.spHelper.setLanguage('ar');
                        setState(() {
                          isSelected[0] = true;
                          isSelected[1] = false;
                        });

                        translator.setNewLanguage(
                          context,
                          newLanguage: 'ar',
                          restart: false,
                          remember: true,
                        );
                        Get.offAll(Splash());
                      } else {
                        SPHelper.spHelper.setLanguage('en');
                        setState(() {
                          isSelected[0] = false;
                          isSelected[1] = true;
                        });

                        translator.setNewLanguage(
                          context,
                          newLanguage: 'en',
                          restart: false,
                          remember: true,
                        );
                        Get.offAll(Splash());
                      }
                    },
                    isSelected: isSelected,
                  ),
                ),
              ),
              ToggleSwitch(
                title: 'Dark Mode',
                image: 'assets/pngs/darkmode.png',
                value: Get.isDarkMode,
                fun: (value) {
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                  appGet.appBarTitleStyle.value = TextStyle(
                      color: Get.isDarkMode ? Colors.black : Colors.white);
                },
              ),
              ToggleSwitch(
                title: 'Finger Print',
                image: 'assets/pngs/fingerprint.png',
                value: appGet.isFingerprint,
                fun: (value) {
                  SPHelper.spHelper.fingerPrintSettings(value);
                },
              ),
              ListTile(
                  leading: Image.asset(
                    'assets/pngs/info.png',
                  ),
                  title: Text(translator.translate('How it Works'))),
              ListTile(
                  leading: Image.asset(
                    'assets/pngs/contact.png',
                  ),
                  title: Text(translator.translate('Contact us'))),
              ListTile(
                  leading: Image.asset(
                    'assets/pngs/agreement.png',
                  ),
                  title: Text(translator.translate('User agreement'))),
              ListTile(
                  leading: Image.asset(
                    'assets/pngs/terms.png',
                  ),
                  title:
                      Text(translator.translate('Draw terms and conditions'))),
              ListTile(
                  leading: Image.asset(
                    'assets/pngs/privacy.png',
                  ),
                  title: Text(translator.translate('Privacy policy'))),
              ListTile(
                  onTap: () {
                    signOut();
                  },
                  leading: Image.asset(
                    'assets/pngs/logout.png',
                  ),
                  title: Text(translator.translate('Logout'))),
            ],
          )),
    );
  }
}

class ToggleSwitch extends StatefulWidget {
  String title;
  String image;
  bool value;
  Function fun;
  ToggleSwitch({this.image, this.title, this.value, this.fun});

  @override
  _toggleSwitchState createState() => _toggleSwitchState();
}

class _toggleSwitchState extends State<ToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(translator.translate(widget.title)),
      leading: Image.asset(
        widget.image,
      ),
      trailing: Switch(
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.value = value;
            widget.fun(value);
          });
        },
      ),
    );
  }
}
