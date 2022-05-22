
import 'package:flutter/material.dart';
import 'package:hmd_chatbot/pages/auth/forms/LoginForm.dart';
import 'package:hmd_chatbot/pages/auth/forms/RegistrationForm.dart';

import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body:  LoginForm());


    //   DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       bottom: TabBar(
    //         indicatorColor: AppColor.indicator,
    //         tabs: [
    //           Tab(text: S.of(context).login),
    //           Tab(text: S.of(context).sign_up),
    //         ],
    //       ),
    //       title: Image.asset("assets/images/Hippocrates.png",width: 150,),
    //     ),
    //     body: const TabBarView(
    //       children: [
    //         LoginForm(),
    //         Text("")
    //         // RegistrationForm(),
    //       ],
    //     ),
    //   ),
    // );
  }

}
