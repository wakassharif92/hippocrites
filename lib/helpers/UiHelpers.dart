import 'package:flutter/material.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';

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