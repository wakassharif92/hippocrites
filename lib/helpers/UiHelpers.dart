import 'package:flutter/material.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';

import '../generated/l10n.dart';

BoxDecoration getButtonDecoration(){
  return  BoxDecoration(
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
ElevatedButton getPrimaryButton(BuildContext context,onClick,String text){
  return  ElevatedButton(

    style: ElevatedButton.styleFrom(primary: AppColor.primary,shadowColor: Colors.white,elevation:0),
    onPressed: onClick,
    child: Text(
     text ,
      style:const  TextStyle(color: Colors.white),
    ),
  );
}
ElevatedButton getSecondaryButton(BuildContext context,onClick,String text){
  return  ElevatedButton(

    style: ElevatedButton.styleFrom(primary: AppColor.btnSecondary,shadowColor: Colors.white,elevation:0),
    onPressed: onClick,
    child: Text(
      text ,
      style:const  TextStyle(color: Colors.white),
    ),
  );
}
ElevatedButton getDimButton(BuildContext context,onClick,String text){
  return  ElevatedButton(

    style: ElevatedButton.styleFrom(primary: AppColor.btnGrey,shadowColor: Colors.white,elevation:0),
    onPressed: onClick,
    child: Text(
      text ,
      style:const  TextStyle(color: Colors.black),
    ),
  );
}