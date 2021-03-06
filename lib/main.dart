import 'package:bbmsg_mobile/Splash.dart';
import 'package:bbmsg_mobile/backend/appGet.dart';
import 'package:bbmsg_mobile/services/shared_prefrences_helper.dart';
import 'package:bbmsg_mobile/services/theme_notifier.dart';
import 'package:bbmsg_mobile/ui/pages/Sign_in.dart';
import 'package:bbmsg_mobile/ui/pages/register_page.dart';
import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:bbmsg_mobile/values/radii.dart';
import 'package:bbmsg_mobile/values/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  await SPHelper.spHelper.initSharedPreferences();

  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (context) {
        return ThemeNotifier(lightTheme);
      },
      child: MyApp(),
    ),
  );
}

// ThemeData themeData = ThemeData(
//   scaffoldBackgroundColor: Colors.white,
// );
// ThemeData themeDataDark = ThemeData(
//   scaffoldBackgroundColor: Colors.white,
//   iconTheme: IconThemeData(color: Colors.blue),
// );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ScreenUtilInit(
      designSize: Size(392.72727272727275, 850.9090909090909),
      allowFontScaling: true,
      child: GetMaterialApp(
        title: 'BBMSG',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: translator.delegates,
        locale: translator.locale,
        supportedLocales: translator.locals(),
        showSemanticsDebugger: false,
        theme: themeNotifier.getTheme(),
        home: MiddlePage(),
      ),
    );
    return ScreenUtilInit(
      designSize: Size(392.72727272727275, 850.9090909090909),
      allowFontScaling: true,
      child: GetMaterialApp(
        title: 'BBMSG',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: translator.delegates,
        locale: translator.locale,
        supportedLocales: translator.locals(),
        showSemanticsDebugger: false,
        theme: themeNotifier.getTheme(),
        home: MiddlePage(),
      ),
    );
  }
}

class MiddlePage extends StatelessWidget {
  AppGet appGet = Get.find();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    appGet.screenHeight = MediaQuery.of(context).size.height;
    appGet.screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
            child: Text('Error Firebase'),
          ));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Splash();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(viewportFraction: 0.8);

  List svgs = ['assets/svgs/'];

  int index = 0;

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
                      onPageChanged: (value) {
                        this.index = value;
                        setState(() {});
                      },
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
                  Column(
                    children: [
                      Container(
                          child: Text(
                        index == 0
                            ? 'Share your Favorites'
                            : index == 1
                                ? 'Customize your Profile'
                                : 'Safe Content',
                        style: Styles.titleTextStyle,
                      )),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                          child: Text(
                        index == 0
                            ? '''You can share your photos, videos and diaries with other users and make new friends '''
                            : index == 1
                                ? '''You can customize your profile to display it to other user '''
                                : '''we handle with reported posts seriously and act on objectionable content reports within 24 hours''',
                        style: Styles.secondTitleTextStyle,
                        textAlign: TextAlign.center,
                      )),
                    ],
                  )
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
                    GestureDetector(
                      onTap: () {
                        Get.off(RegisterPage());
                        //  Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return RegisterPage();
                        // }));
                      },
                      child: Container(
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
                            color: primaryColor,
                            borderRadius: Radii.k8pxRadius),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(SignIn());
                      },
                      child: Container(
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
