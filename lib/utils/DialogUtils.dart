// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';

// class DialogUtils {
//   static void showAlertDialog(BuildContext context, String content,
//       [Function procedure]) {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text(translator.translate("alert")),
//           content: new Text(content),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             new FlatButton(
//               child: new Text(translator.translate("close")),
//               onPressed: () {
//                 if (procedure != null) {
//                   Navigator.of(context).pop();
//                   procedure();
//                 } else {
//                   Navigator.of(context).pop();
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
