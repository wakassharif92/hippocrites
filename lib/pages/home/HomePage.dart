import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/components/Chat.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/pages/home/ProfilePage.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchMode = false;
  late ItemScrollController itemScrollController;
  int activeIndex = 2;

  @override
  void initState() {
    itemScrollController = ItemScrollController();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.chatBg,

        // appBar:AppBar(
        //   backgroundColor: AppColor.primary,
        //   title: searchMode
        //       ? TextField(
        //           cursorColor: AppColor.searchText,
        //           onChanged: (s) {
        //             int? id = BlocProvider.of<ChatCubit>(context).findMessage(s);
        //             if (id != null) {
        //               itemScrollController.scrollTo(
        //                   index: id, duration: Duration(milliseconds: 300));
        //             }
        //           },
        //           style: TextStyle(color: AppColor.searchText),
        //           decoration: InputDecoration.collapsed(
        //             hintText: S.of(context).search,
        //             hintStyle: TextStyle(color: AppColor.searchText),
        //           ))
        //       : Image.asset(
        //           "assets/images/Hippocrates.png",
        //           width: 150,
        //         ),
        //   actions: [
        //     IconButton(
        //         icon: Icon(searchMode ? Icons.clear : Icons.search),
        //         onPressed: () {
        //           setState(() {
        //             searchMode = !searchMode;
        //           });
        //         }),
        //     PopupMenuButton<String>(
        //       onSelected: (s) {
        //         switch (s) {
        //           case "logout":
        //             BlocProvider.of<AuthCubit>(context).logOut();
        //             break;
        //           case "start_over":
        //             BlocProvider.of<ChatCubit>(context).initChat();
        //             break;
        //           case "profile":
        //             Navigator.of(context).push(MaterialPageRoute(
        //                 builder: (c) => BlocProvider(
        //                     create: (BuildContext context) => UserDataCubit(
        //                         storageFactory: StorageFactory(),
        //                         apiFactory: APIFactory()),
        //                     child: const ProfilePage())));
        //             break;
        //         }
        //       },
        //       itemBuilder: (context) {
        //         return [
        //            PopupMenuItem(
        //             value: "profile",
        //             child: Padding(
        //               padding: EdgeInsets.only(right: 20),
        //               child: Text(S.of(context).profile),
        //             ),
        //           ),
        //            PopupMenuItem(
        //             value: "start_over",
        //             child: Padding(
        //               padding: EdgeInsets.only(right: 20),
        //               child: Text(S.of(context).start_over),
        //             ),
        //           ),
        //            PopupMenuItem(
        //             value: "logout",
        //             child: Padding(
        //               padding: EdgeInsets.only(right: 20),
        //               child: Text(S.of(context).logout),
        //             ),
        //           ),
        //         ];
        //       },
        //     )
        //   ],
        // ),
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(children: <Widget>[
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
                    child: Text(
                      (activeIndex == 2)
                          ? "Ask a question"
                          : (activeIndex == 4)
                              ? "Account settings"
                              : "",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )),
            ),
            Expanded(
              child: _buildScreens(activeIndex),
            ),
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
                    topLeft: Radius.circular(40.w),
                    topRight: Radius.circular(40.w)),
              ),
              height: 104.h,
              padding: EdgeInsets.only(top: 18.h, left: 25.13.w),
              width: double.infinity,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  InkWell(
                      child: getNavIcon(0, false, "Start Over"),
                      onTap: () {
                        BlocProvider.of<ChatCubit>(context).initChat();
                      }),
                  SizedBox(
                    width: 22.25.w,
                  ),
                  InkWell(
                      child: getNavIcon(1, false, "Diagnosis"),
                      onTap: () {
                        updateActiveTab(1);
                      }),
                  SizedBox(
                    width: 22.13.w,
                  ),
                  InkWell(
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
                                        "assets/images/nav/3.svg",
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
                            "Ask a question",
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      ),
                      onTap: () {
                        updateActiveTab(2);
                      }),
                  SizedBox(
                    width: 27.63.w,
                  ),
                  InkWell(
                      child: getNavIcon(3, false, "Library"),
                      onTap: () {
                        updateActiveTab(3);
                      }),
                  SizedBox(
                    width: 27.63.w,
                  ),
                  InkWell(
                      child: getNavIcon(4, false, "Profile"),
                      onTap: () {
                        updateActiveTab(4);
                      }),
                ],
              ),
            )
          ]),
        )

        // Chat(
        //   itemScrollController: itemScrollController,
        // ),
        );
  }

  updateActiveTab(index) {
    print("called");
    setState(() {
      activeIndex = index;
    });
  }

  Widget getNavIcon(int index, bool isActive, String title) {
    return Column(
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
    );
  }

  Widget _buildScreens(index) {
    return [
      Center(child: Text("screen 1 ")),
      Center(child: Text("screen 2")),
      Chat(
        itemScrollController: itemScrollController,
      ),
      Center(child: Text("screen 4")),
      BlocProvider(
          create: (BuildContext context) => UserDataCubit(
              storageFactory: StorageFactory(), apiFactory: APIFactory()),
          child: const ProfilePage())
    ].elementAt(index);
  }
}
