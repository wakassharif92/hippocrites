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
  int activeIndex = 2;

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

              child: _buildScreens(activeIndex),
            ),
Container(
  height: 104.h,
  width: double.infinity,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    InkWell(

        child: Container(
            color: Colors.red,
            height: 40,
            width: 40,
            child: Text("1")),
        onTap:(){
          updateActiveTab(0);
      }
    ),
    Text("2sdfsdf"),
      InkWell(

          child: Container(
              color: Colors.red,
              height: 40,
              width: 40,
              child: Text("3")),
          onTap:(){
            updateActiveTab(2);
          }
      ),
    Text("4"),
    Text("5"),
  ],),
)
          ]
        ),
      )

      // Chat(
      //   itemScrollController: itemScrollController,
      // ),
    );
  }
  updateActiveTab(index){
    print("called");
    setState(() {
      activeIndex = index;
    });


  }
  Widget getNavIcon(){
    return Column(children: [

    ],);
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
              storageFactory: StorageFactory(),
              apiFactory: APIFactory()),
          child: const ProfilePage())
    ].elementAt(index);
  }

}
