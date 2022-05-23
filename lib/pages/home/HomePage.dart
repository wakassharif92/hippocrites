import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    itemScrollController = ItemScrollController();
  }
  final PersistentTabController _controller =  PersistentTabController(initialIndex: 0);


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
      body:Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children:<Widget>[
            Container(
              width: 375.w,
              height: 117.h,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.only(

                    bottomRight: Radius.circular(16.w),

                    bottomLeft: Radius.circular(16.w)),

              ),
              child: Align(alignment: Alignment.bottomLeft,child: Padding(

                padding:  EdgeInsets.only(left: 16.w , bottom: 30.h),
                child: Text("Account",style: Theme.of(context).textTheme.headline4,),
              )),
            ),
            Expanded(

              child: PersistentTabView(
                context,
                controller: _controller,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Colors.white, // Default is Colors.white.
                handleAndroidBackButtonPress: true, // Default is true.
                resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: Colors.white,
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
              ),
            ),

          ]
        ),
      )

      // Chat(
      //   itemScrollController: itemScrollController,
      // ),
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.settings),
        title: ("Settings"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  List<Widget> _buildScreens() {
    return [
      Center(child: Text("screen 1 ")),
      Center(child: Text("screen 2")),
      Chat(
        itemScrollController: itemScrollController,
      ),
      Center(child: Text("screen 4")),
      BlocProvider(
          create: (BuildContext context) => UserDataCubit(
              storageFactory: StorageFactory(),
              apiFactory: APIFactory()),
          child: const ProfilePage())
    ];
  }

}
