import 'package:flutter/material.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../generated/l10n.dart';

BoxDecoration getButtonDecoration() {
  return BoxDecoration(
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: AppColor.primary.withOpacity(0.3),
        blurRadius: 30,
        spreadRadius: 10,
        offset: Offset(0, 18),
      ),
    ],
  );
}

ElevatedButton getPrimaryButton(BuildContext context, onClick, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: AppColor.primary, shadowColor: Colors.white, elevation: 0),

    onPressed: onClick,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

ElevatedButton getSecondaryButton(BuildContext context, onClick, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: AppColor.btnSecondary,
        shadowColor: Colors.white,
        elevation: 0),
    onPressed: onClick,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

ElevatedButton getDimButton(BuildContext context, onClick, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: AppColor.btnGrey, shadowColor: Colors.white, elevation: 0),
    onPressed: onClick,
    child: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
  );
}
ElevatedButton getBlackCustomButton(BuildContext context,Function onClick, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: AppColor.darkPurple, shadowColor: Colors.white, elevation: 0),
    onPressed: (){
      onClick();
    },
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
Widget chatMessage(String text, type) {
  return Container(
    padding: EdgeInsets.only(bottom: 16.h),
    child: Align(
      alignment: (type == "R"?Alignment.topLeft:Alignment.topRight),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: type=="R"?BorderRadius.only(
              topRight: Radius.circular(24.sp),
              topLeft: Radius.circular(24.sp),
              bottomRight: Radius.circular(24.sp),
          ):
          BorderRadius.only(
            topRight: Radius.circular(24.sp),
            topLeft: Radius.circular(24.sp),
            bottomLeft: Radius.circular(24.sp),),
          color: (type  == "R"?AppColor.msgReceived:AppColor.msgSent),
        ),
        padding: EdgeInsets.all(16.sp),
        child: Text(text, style: TextStyle(color: type  == "R"?Colors.black:Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600)
          ,),
      ),
    ),
  );
}

InputDecoration getSearchDecoration(){
  return  InputDecoration(

      filled: true,

      fillColor: Colors.white,
      errorStyle: TextStyle(
        color: AppColor.error,
      ),
      contentPadding:
      EdgeInsets.only(left: 28.w, top: 26.h, bottom: 16.h),

      // labelStyle: TextStyle(
      //     fontSize: 14.sp,
      //     color: Colors.black,
      //     fontWeight: FontWeight.w500),
    hintText: "Search",
      hintStyle: TextStyle(
          fontSize: 13.sp,
          color: AppColor.searchLabelText,
          fontWeight: FontWeight.w300),

      enabledBorder: InputBorder.none,
      disabledBorder: InputBorder.none,

      focusedBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      border: InputBorder.none,);
}
