import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/pages/auth/AuthPage.dart';
import 'package:hmd_chatbot/pages/home/HomePage.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthCubit, bool>(builder: (ctx, loggedIn) {
      if(loggedIn) {
        return BlocProvider(
            create: (BuildContext context) => ChatCubit(
                storageFactory: StorageFactory(), apiFactory: APIFactory()),child: const HomePage());
      } else {
        return const AuthPage();
      }
    });
  }
}
