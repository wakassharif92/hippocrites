import 'package:flutter/material.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';

class CheckEmailDialog extends StatelessWidget {
  const CheckEmailDialog({Key? key, required this.message }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius:
      BorderRadius.all(Radius.circular(50))),
        child: Container(
          width: size.width - 40,
          decoration: BoxDecoration(color: AppColor.dialogBg, borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.all(10),
          height:  250, child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/images/logoPic.png", height: 50,),
              Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
              Text(S.of(context).check_email, textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
            ],
          ),));
  }
}
