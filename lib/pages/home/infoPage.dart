import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(top: 120.h),
              height: 60.h,
              // width: 50.h,
              child: Image.asset(
                "assets/images/logoPic.png",
                color: AppColor.primary
              )),
          Text("Hippocrates",style: TextStyle(fontSize: 20.h),),
          SizedBox(height: 20.h,),
          Row(children: [
            SizedBox(width:40.w,child: Icon(Icons.location_on_outlined,color: AppColor.primary,size: 40.h,)),
            const Expanded(child:  Text("GBT Technologies.2500 Broadway, Suite F-125 Santa Monica, CA 90404 USA"))
          ],),
          SizedBox(height: 10.h,),
          Row(children: [
            SizedBox(width: 40.w,child: Icon(Icons.email,color: AppColor.primary,size: 30.h,)),
            const Expanded(child:   Text("info@gbtti.com"))
          ],),
          SizedBox(height: 10.h,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            SizedBox(width: 40.w,child: Icon(Icons.info_outline_rounded,color: AppColor.primary,size: 30.h,)),
            const Expanded(child:   Text("Hippocrates health system is an AI based medical advisor. Users may provide symptoms, ask medical questions and describe conditions in order to get diagnosis advise, including known medication and treatments.",
            // textAlign: TextAlign.justify
              ))
          ],),
          SizedBox(height: 10.h,),
          Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
            SizedBox(width: 40.w,child: Icon(Icons.copyright_outlined,color: AppColor.primary,size: 30.h,)),
            const Expanded(child:   Text("All rights reserved Copyright © 2022 GBT Technologies, Inc. (“GBT”)",
            // textAlign: TextAlign.justify
              ))
          ],),
        ],
      ),
    );
  }
}
