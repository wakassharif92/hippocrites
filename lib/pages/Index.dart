import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/pages/auth/AuthPage.dart';
import 'package:hmd_chatbot/pages/home/HomePage.dart';
import 'package:hmd_chatbot/pages/intro/intro_one.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool introCompleted=false;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthCubit, bool>(builder: (ctx, loggedIn) {
      if(loggedIn&&introCompleted) {

        return
          BlocProvider(
            create: (BuildContext context) => ChatCubit(
                storageFactory: StorageFactory(), apiFactory: APIFactory()),child: const HomePage());
      } else if (loggedIn && !introCompleted){
        return IntroOne((){
          setState(() {
            introCompleted=true;
          });
        });
      }else {
        return const AuthPage();
      }
    });
  }
}
