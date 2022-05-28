import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';

class IntroOne extends StatelessWidget {
  VoidCallback callback;
  IntroOne(this.callback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
                image: AssetImage("assets/images/intro_bg.png"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, left: 16.w),
              child: Row(
                children: [
                  Container(
                    width: 113.w,
                    height: 4.h,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    width: 113.w,
                    height: 4.h,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.32)),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    width: 113.w,
                    height: 4.h,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.32)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Skip",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 48.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 65.w),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
                  chatMessage("Hello!", "R"),
                  chatMessage("Can i help you?", "R"),
                  chatMessage("Hi, i have a headache!", "S"),
                ],
              ),
            ),
            SizedBox(
              height: 332.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 280.w,
                  child: ElevatedButton(
                    onPressed: callback,
                    child: Text("Next",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
