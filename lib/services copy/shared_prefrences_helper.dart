// import 'package:bbmsg_mobile/backend/appGet.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SPHelper {
//   SPHelper._();
//   AppGet appGet = Get.put(AppGet());

//   static final SPHelper spHelper = SPHelper._();
//   SharedPreferences prefs;

//   Future<SharedPreferences> initSharedPreferences() async {
//     if (prefs == null) {
//       prefs = await SharedPreferences.getInstance();
//     }
//     return prefs;
//   }

//   setLanguage(String lan) async {
//     prefs = await spHelper.initSharedPreferences();
//     prefs.setString('language', lan);
//   }

//   Future<String> getLanguage() async {
//     prefs = await spHelper.initSharedPreferences();
//     String language = prefs.getString('language');
//     return language;
//   }

//   bool showTermAndCondition() {
//     bool showTermCondition = prefs.getBool('showTermCondition');
//     return showTermCondition != null ? showTermCondition : true;
//   }

//   setShowTermAndCondition(bool value) {
//     prefs.setBool('showTermCondition', value);
//   }

//   saveToken(String token) {
//     prefs.setString('token', token);
//   }

//   String getToken() {
//     String token = prefs.getString('token');

//     if (token != null) {
//       return token;
//     } else {
//       return null;
//     }
//   }

//   clearSp() {
//     prefs.clear();
//   }
// }
