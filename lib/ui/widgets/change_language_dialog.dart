import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 150.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close))),
              Text(
                translator.translate("change_language"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 198, 6, 40),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8.w, left: 8.w),
                    padding: EdgeInsets.only(right: 8.w, left: 8.w),
                    height: 50,
                    decoration: BoxDecoration(
                      color: translator.currentLanguage == "ar"
                          ? primaryColor
                          : Colors.black12,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(18, 0, 0, 0),
                          offset: Offset(0.w, 5.h),
                          blurRadius: 14,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop('ar');
                      },
                      child: Center(
                        child: Text(
                          "عربي",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    padding: EdgeInsets.only(right: 8, left: 8),
                    height: 50,
                    decoration: BoxDecoration(
                      color: translator.currentLanguage == "en"
                          ? primaryColor
                          : Colors.black12,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(18, 0, 0, 0),
                          offset: Offset(0, 5),
                          blurRadius: 14,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop('en');
                      },
                      child: Center(
                        child: Text(
                          "English",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
