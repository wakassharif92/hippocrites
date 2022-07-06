import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/pages/auth/AuthPage.dart';
import 'package:hmd_chatbot/pages/home/HomePage.dart';
import 'package:hmd_chatbot/pages/intro/intro_one.dart';
import 'package:hmd_chatbot/pages/splash.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool introCompleted = false;
  bool splash = false;
  @override
  void initState() {
    setState(() {
      showSplash();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return splash
        ? const Splash()
        : BlocBuilder<AuthCubit, bool>(builder: (ctx, loggedIn) {
            if (loggedIn && introCompleted) {
              return BlocProvider(
                  create: (BuildContext context) => ChatCubit(
                      storageFactory: StorageFactory(),
                      apiFactory: APIFactory()),
                  child: HomePage());
            } else if (loggedIn && !introCompleted) {
              return IntroOne(() {
                setState(() {
                  introCompleted = true;
                });
              });
            } else {
              return const AuthPage();
            }
          });
  }

  showSplash() async {
    splash=true;
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      splash=false;
    });
print(splash);
  }
}
