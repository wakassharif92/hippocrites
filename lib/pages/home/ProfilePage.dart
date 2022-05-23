import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/pages/home/settings/PasswordSettings.dart';
import 'package:hmd_chatbot/pages/home/settings/ProfileSettings.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: AppColor.primary,
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back_outlined),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   bottom: ,
          // ),
          body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Stack(
              children: [

                Positioned(
                  bottom: 0,
                  child: Row(
                    children: [
                      Container(

                        width: (MediaQuery.of(context).size.width*1),

                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 2, color: Colors.grey),
                          ),


                        )
                      ),
                    ],
                  ),
                ),
                Container(

                  child: TabBar(
                    labelColor: AppColor.primary,
                    indicatorColor: AppColor.primary,
                    unselectedLabelColor: Colors.black,
                    labelStyle: Theme.of(context).textTheme.headline3,
                    // unselectedLabelStyle: AppColor.primary,
                    tabs: [
                      Tab(
                        text: S.of(context).prof_settings,
                      ),
                      Tab(text: S.of(context).pass_settings),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ProfileSettings(),
                PasswordSettings(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
