import 'package:bbmsg_mobile/Splash.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/radii.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            titleTextStyle: Styles.titleTextStyle,
            title: translator.translate('important_settings'),
            tiles: [
              SettingsTile(
                  title: translator.translate('language'),
                  leading: Image.asset(
                    'assets/pngs/language.png',
                  ),
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
                  )),
              SettingsTile.switchTile(
                switchActiveColor: primaryColor,
                title: translator.translate('Dark Mode'),
                leading: Image.asset(
                  'assets/pngs/darkmode.png',
                ),
                switchValue: true,
                onToggle: (bool value) {},
              ),
              SettingsTile.switchTile(
                switchActiveColor: primaryColor,
                title: translator.translate('Finger Print'),
                leading: Image.asset(
                  'assets/pngs/fingerprint.png',
                ),
                switchValue: true,
                onToggle: (bool value) {
                  Get.isDarkMode
                      ? Get.changeThemeMode(ThemeMode.light)
                      : Get.changeThemeMode(ThemeMode.dark);
                },
              ),
              SettingsTile(
                title: translator.translate('How it Works'),
                leading: Image.asset(
                  'assets/pngs/info.png',
                ),
              ),
              SettingsTile(
                title: translator.translate('Contact us'),
                leading: Image.asset(
                  'assets/pngs/contact.png',
                ),
              ),
              SettingsTile(
                title: translator.translate('User agreement'),
                leading: Image.asset(
                  'assets/pngs/agreement.png',
                ),
              ),
              SettingsTile(
                title: translator.translate('Draw terms and conditions'),
                leading: Image.asset(
                  'assets/pngs/terms.png',
                ),
              ),
              SettingsTile(
                title: translator.translate('Privacy policy'),
                leading: Image.asset(
                  'assets/pngs/privacy.png',
                ),
              ),
              SettingsTile(
                title: translator.translate('Logout'),
                leading: Image.asset(
                  'assets/pngs/logout.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class toggleSwitch extends StatefulWidget {
  String title;
  String image;
  bool value;
  Function fun;
  toggleSwitch({this.image, this.title, this.value, this.fun});

  @override
  _toggleSwitchState createState() => _toggleSwitchState();
}

class _toggleSwitchState extends State<toggleSwitch> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SettingsTile.switchTile(
      switchActiveColor: primaryColor,
      title: translator.translate(widget.title),
      leading: Image.asset(
        widget.image,
      ),
      switchValue: widget.value,
      onToggle: (bool value) {
        widget.value = value;
        widget.fun();
      },
    );
  }
}
