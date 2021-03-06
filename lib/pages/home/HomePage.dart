import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/components/Chat.dart';
import 'package:hmd_chatbot/components/chat_d.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';
import 'package:hmd_chatbot/models/db/databaseHelper.dart';
import 'package:hmd_chatbot/pages/home/ProfilePage.dart';
import 'package:hmd_chatbot/pages/home/infoPage.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/Storage.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../chatHistory/chatHistory.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchMode = false;
  late ItemScrollController itemScrollController;
  int activeIndex = 2;
  bool _isLoading = false;
  FocusNode searcFocus = FocusNode();
  final String MAD = "Make a diagnosis";
  String AAQ = "Ask a question";
  TextEditingController ctrlSearch = TextEditingController();

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    searcFocus.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
          backgroundColor: AppColor.chatBg,
          body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              children: [
                Column(children: <Widget>[
                  Container(
                    width: 375.w,
                    height: 117.h,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(16.w),
                          bottomLeft: Radius.circular(16.w)),
                    ),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w, bottom: 30.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (activeIndex == 0)
                                    ? "Info"
                                    : (activeIndex == 1)
                                        ? "Diagnosis"
                                        : (activeIndex == 2)
                                            ? "Ask a question"
                                            : (activeIndex == 3)
                                                ? "Library"
                                                : (activeIndex == 4)
                                                    ? "Account settings"
                                                    : "",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              if (activeIndex == 1 || activeIndex == 2)
                                GestureDetector(
                                  onTap: () {
                                    //     .initChat(activeIndex == 1 ? MAD : AAQ);
                                    Storage s = StorageFactory().getStorage();
                                    if (s.getCurrentScreen == AAQ) {
                                      s.clearAAQ();
                                      BlocProvider.of<ChatCubit>(context)
                                          .makeStateEmpty();
                                      BlocProvider.of<ChatCubit>(context)
                                          .initChat(AAQ);
                                    } else {
                                      s.clearMAD();
                                      BlocProvider.of<ChatCubit>(context)
                                          .makeStateEmpty();
                                      BlocProvider.of<ChatCubit>(context)
                                          .initChat(MAD);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 15.w, left: 15.w),
                                    //child: Container(child: Icon(Icons.refresh,color: Colors.white,)),
                                    child: Container(
                                        child: const Text(
                                      'Clear History',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                )
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    child: _buildScreens(activeIndex),
                  ),
                  if (!isKeyboardVisible)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.w),
                            topRight: Radius.circular(0.w)),
                      ),
                      height: 104.h,
                      padding: EdgeInsets.only(top: 18.h, left: 0.w),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              SizedBox(
                                width: 16.w,
                              ),
                              InkWell(
                                  child: getNavIcon(0, false, "Info"),
                                  onTap: () {
                                    updateActiveTab(0);
                                    // BlocProvider.of<ChatCubit>(context)
                                    //     .initChat();
                                  }),

                              InkWell(
                                  child: getNavIcon(1, false, "Diagnosis"),
                                  onTap: () {
                                    updateActiveTab(1);
                                  }),
                              // SizedBox(
                              //   width: 22.13.w,
                              // ),
                              //
                              InkWell(
                                  child: getNavIcon(2, false, 'Ask a Question'),
                                  onTap: () {
                                    updateActiveTab(2);
                                  }),
                              // InkWell(
                              //     child: getNavIcon(3, false, "Library"),
                              //     onTap: () {
                              //       updateActiveTab(3);
                              //     }),
                              // SizedBox(
                              //   width: 27.63.w,
                              // ),
                              InkWell(
                                  child: getNavIcon(4, false, "Profile"),
                                  onTap: () {
                                    updateActiveTab(4);
                                  }),
                              SizedBox(
                                width: 16.w,
                              ),
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     InkWell(
                          //         child: Column(
                          //           children: [
                          //             Stack(
                          //               children: [
                          //                 Container(
                          //                   width: 72.w,
                          //                   height: 40.h,
                          //                   decoration: BoxDecoration(
                          //                     color: AppColor.primary,
                          //                     borderRadius:
                          //                         BorderRadius.circular(14.h),
                          //                     boxShadow: <BoxShadow>[
                          //                       BoxShadow(
                          //                         color: AppColor.primary
                          //                             .withOpacity(0.3),
                          //                         blurRadius: 20,
                          //                         spreadRadius: 5,
                          //                         offset: Offset(0, 10),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Positioned.fill(
                          //                   child: Align(
                          //                     child: Container(
                          //                       height: 24.h,
                          //                       width: 24.h,
                          //                       child: SvgPicture.asset(
                          //                           "assets/images/nav/3.svg",
                          //                           height: 24.h
                          //                           // semanticsLabel: 'Acme Logo'
                          //                           ),
                          //                     ),
                          //                   ),
                          //                 )
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: 4.h,
                          //             ),
                          //             Text(
                          //               "Ask a question",
                          //               style: Theme.of(context)
                          //                   .textTheme
                          //                   .headline5,
                          //             )
                          //           ],
                          //         ),
                          //         onTap: () {
                          //           updateActiveTab(2);
                          //         }),
                          //   ],
                          // )
                        ],
                      ),
                    )
                ]),
                if (activeIndex == 2 || activeIndex == 1)
                  Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.h),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 2,
                          offset: Offset(0, 18),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(top: 93.h, left: 16.w, right: 16.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: SvgPicture.asset("assets/images/search.svg",
                              height: 24.h
                              // semanticsLabel: 'Acme Logo'
                              ),
                        ),
                        Expanded(
                          child: Container(
                            child: TextField(
                                focusNode: searcFocus,
                                cursorColor: AppColor.searchLabelText,
                                controller: ctrlSearch,
                                onChanged: (s) {
                                  int? id = BlocProvider.of<ChatCubit>(context)
                                      .findMessage(s);
                                  if (id != null) {
                                    itemScrollController.scrollTo(
                                        index: id,
                                        duration: Duration(milliseconds: 300));
                                  }
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: getSearchDecoration()),
                          ),
                        ),
                        searcFocus.hasFocus
                            ? InkWell(
                                onTap: () {
                                  ctrlSearch.text = "";
                                },
                                child: Container(
                                  height: double.maxFinite,
                                  // color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 24.w),
                                    child: SvgPicture.asset(
                                      "assets/images/close.svg",

                                      // semanticsLabel: 'Acme Logo'
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 100.w,
                              )
                      ],
                    ),
                  )
              ],
            ),
          )

          // Chat(
          //   itemScrollController: itemScrollController,
          // ),
          ),
    );
  }

  updateActiveTab(index) {
    setState(() {
      activeIndex = index;
    });
  }

  Widget getNavIcon(int index, bool isActive, String title) {
    return activeIndex == index
        ? Container(
            width: 90.w,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 72.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(14.h),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColor.primary.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        child: Container(
                          height: 24.h,
                          width: 24.h,
                          child: SvgPicture.asset(
                              "assets/images/activeNav/${index + 1}.svg",
                              height: 24.h
                              // semanticsLabel: 'Acme Logo'
                              ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          )
        : Container(
            width: 60.w,
            child: Column(
              children: [
                Container(
                  height: 24.h,
                  width: 24.h,
                  child: SvgPicture.asset("assets/images/nav/${index + 1}.svg",
                      height: 24.h
                      // semanticsLabel: 'Acme Logo'
                      ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h),
                  width: 24.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                      color: activeIndex == index
                          ? AppColor.primary
                          : Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          );

    return Container(
      width: 60.w,
      child: Column(
        children: [
          Container(
            height: 24.h,
            width: 24.h,
            child: SvgPicture.asset("assets/images/nav/${index + 1}.svg",
                height: 24.h
                // semanticsLabel: 'Acme Logo'
                ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            width: 24.w,
            height: 2.h,
            decoration: BoxDecoration(
                color: activeIndex == index ? AppColor.primary : Colors.black,
                borderRadius: BorderRadius.circular(50)),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }

  Widget _buildScreens(index) {
    var a = [
      const InfoPage(),
      // const Center(child: Text("Info comming soon")),
      ChatD(
        itemScrollController: itemScrollController,
      ),
      Chat(
        itemScrollController: itemScrollController,
      ),
      ChatHistory(),
      BlocProvider(
          create: (BuildContext context) => UserDataCubit(
              storageFactory: StorageFactory(), apiFactory: APIFactory()),
          child: const ProfilePage())
    ].elementAt(index);
    return a;
  }

  @override
  void dispose() {
    super.dispose();
    searcFocus.removeListener(() {});
    searcFocus.dispose();
  }
}
