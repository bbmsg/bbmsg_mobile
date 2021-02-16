import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/backend/server.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:bbmsg_mobile/ui/pages/block_screen.dart';
import 'package:bbmsg_mobile/ui/pages/contact_us.dart';
import 'package:bbmsg_mobile/ui/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

  bool isFingerprint = false;
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
        appBar: CustomAppBar('Settings'),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 25.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ListTile(
                  //   leading: Image.asset(
                  //     'assets/pngs/language.png',
                  //   ),
                  //   title: Text(translator.translate('language')),
                  //   trailing: Container(
                  //     height: 45.h,
                  //     child: ToggleButtons(
                  //       borderColor: primaryColor,
                  //       fillColor: primaryColor,
                  //       borderWidth: 2,
                  //       selectedBorderColor: primaryColor,
                  //       selectedColor: Colors.white,
                  //       borderRadius: Radii.k8pxRadius,
                  //       children: <Widget>[
                  //         Container(
                  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //           child: Text(
                  //             translator.translate('arabic'),
                  //             style: TextStyle(fontSize: 17),
                  //           ),
                  //         ),
                  //         Container(
                  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //           child: Text(
                  //             translator.translate('english'),
                  //             style: TextStyle(fontSize: 17),
                  //           ),
                  //         ),
                  //       ],
                  //       onPressed: (int index) {
                  //         if (index == 0) {
                  //           SPHelper.spHelper.setLanguage('ar');
                  //           setState(() {
                  //             isSelected[0] = true;
                  //             isSelected[1] = false;
                  //           });

                  //           translator.setNewLanguage(
                  //             context,
                  //             newLanguage: 'ar',
                  //             restart: false,
                  //             remember: true,
                  //           );
                  //           Get.offAll(Splash());
                  //         } else {
                  //           SPHelper.spHelper.setLanguage('en');
                  //           setState(() {
                  //             isSelected[0] = false;
                  //             isSelected[1] = true;
                  //           });

                  //           translator.setNewLanguage(
                  //             context,
                  //             newLanguage: 'en',
                  //             restart: false,
                  //             remember: true,
                  //           );
                  //           Get.offAll(Splash());
                  //         }
                  //       },
                  //       isSelected: isSelected,
                  //     ),
                  //   ),
                  // ),

                  // Container(
                  //   color: appGet.isDarkMode.value
                  //       ? Colors.white.withOpacity(0.12)
                  //       : Colors.white,
                  //   child: ToggleSwitch(
                  //     title: 'Dark Mode',
                  //     image: 'assets/svgs/newDark.png',
                  //     value: _darkTheme,
                  //     fun: (value) {
                  //       onThemeChanged(value, themeNotifier);
                  //     },
                  //   ),
                  // ),
                  // ListTile(
                  //     leading: Image.asset(
                  //       'assets/pngs/info.png',
                  //     ),
                  //     title: Text(translator.translate('How it Works'))),

                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: ListTile(
                        onTap: () {
                          Get.to(ContactUsPage());
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Image.asset(
                          'assets/pngs/contact.png',
                          width: 40,
                          height: 40,
                        ),
                        title: Text(translator.translate('Contact us'))),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: Column(
                      children: [
                        ListTile(
                            onTap: () {
                              launch(
                                  'http://ec2-3-23-216-129.us-east-2.compute.amazonaws.com:7425/bbmsg-terms-and-conditions.html');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading: Image.asset(
                              'assets/pngs/terms.png',
                              width: 40,
                              height: 40,
                            ),
                            title: Text(translator
                                .translate('Draw terms and conditions'))),
                        Divider(
                          color: Colors.black.withOpacity(0.12),
                        ),
                        ListTile(
                            onTap: () {
                              launch(
                                  'http://ec2-3-23-216-129.us-east-2.compute.amazonaws.com:7425/bbmsg-privacy-policy.html');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading: Image.asset(
                              'assets/pngs/privacy.png',
                              width: 40,
                              height: 40,
                            ),
                            title:
                                Text(translator.translate('Privacy policy'))),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: ListTile(
                        onTap: () {
                          Get.to(BlockScreen());
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Image.asset(
                          'assets/pngs/block.png',
                          width: 40,
                          height: 40,
                        ),
                        title: Text(translator.translate('Block area'))),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 20.h),
                    child: ListTile(
                        onTap: () {
                          signOut();
                        },
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Image.asset(
                          'assets/pngs/logout.png',
                          width: 40,
                          height: 40,
                        ),
                        title: Text(translator.translate('Logout'))),
                  ),
                ],
              ),
            )));
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
        width: 40,
        height: 40,
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
