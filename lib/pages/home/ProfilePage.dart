import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/pages/home/settings/PasswordSettings.dart';
import 'package:hmd_chatbot/pages/home/settings/ProfileSettings.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/UserData.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(labelColor: AppColor.text2,
            indicatorColor: AppColor.indicator,
            tabs: [
              Tab(text: S.of(context).prof_settings),
              Tab(text: S.of(context).pass_settings),
            ],
          ),
        ),
        body:  const TabBarView(
          children: [
            ProfileSettings(),
            PasswordSettings(),
          ],
        )
      ),
    );
  }


}
