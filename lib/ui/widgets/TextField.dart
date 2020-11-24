import 'package:bbmsg_mobile/values/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  TextEditingController editingController = TextEditingController();
  String hintTextKey;
  IconData iconData;
  Function saveFunction;
  Function validateFunction;
  int nofLines;
  TextInputType inputType;
  String content;
  Color borderColor;
  String svgAsset;
  MyTextField(
      {this.hintTextKey,
      this.iconData,
      this.saveFunction,
      this.validateFunction,
      this.nofLines = 1,
      this.inputType = TextInputType.text,
      this.content,
      this.borderColor,
      this.svgAsset}) {
    if (content != null) {
      editingController.text = content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0.w),
        borderRadius: BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SvgPicture.asset(
              svgAsset,
              height: 20.h,
              width: 20.w,
              semanticsLabel: 'Acme Logo2',
              color: primaryColor,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: TextFormField(
                controller: editingController,
                maxLines: nofLines,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).nextFocus();
                },
                textInputAction: TextInputAction.next,
                keyboardType: inputType,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: translator.translate(hintTextKey),
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                validator: (value) {
                  return validateFunction(value);
                },
                onSaved: (newValue) => saveFunction(newValue),
                onChanged: (value) => saveFunction(value),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(18, allowFontScalingSelf: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
