import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/components/ChatMessage.dart';
import 'package:hmd_chatbot/components/OptionsDialog.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chat extends StatefulWidget {
  final String typeOfChat;
    Chat({Key? key, required this.itemScrollController,required this.typeOfChat})
      : super(
          key: key,
        );
  final ItemScrollController itemScrollController;

  @override
  _ChatState createState(){
    print(typeOfChat);
    // BlocProvider.of<ChatCubit>(currentc).initChat(typeOfChat);
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    print("type");
    print(widget.typeOfChat);
    BlocProvider.of<ChatCubit>(context).initChat(widget.typeOfChat);
    super.initState();
  }

  TextEditingController _messageController = TextEditingController();

  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (c, state) => Column(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              color: Colors.transparent,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment(0.0, 0.90),
                    end: Alignment(0.0, 0.98),
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: ScrollablePositionedList.builder(
                  itemScrollController: widget.itemScrollController,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) {
                    var m = state.messages;
                    var e = m[m.length - index - 1];
                    return Column(

                      children: [
                        ChatMessage(e, selectedOptions),
                   if (state.inputType == "autocompite" &&index == 0)
                    Container(
                          width: MediaQuery.of(context).size.width * 1,
                          padding:
                          EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColor.darkPurple,
                                shadowColor: Colors.white,
                                elevation: 0),
                            onPressed: () {
                              showOptionSheet(state);
                            },
                            child: Text(
                              "Choose symptoms",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: state.messages.length,
                ),
              ),
            ),
          )),
          Container(
            width: double.maxFinite,
            child: pickInput(context, state),
          )
        ],
      ),
    );
  }

  showOptionSheet(ChatState state) async {
    // selectedOptions = [];
     await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (c) => OptionsDialog(
              selected: selectedOptions,
              options: state.options ?? [],
            ));

     setState(() {});
    return ;

  }

  Widget pickInput(BuildContext context, ChatState state) {
    switch (state.inputType) {
      case "button":
        selectedOptions = [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            children: state.options
                    ?.map((e) => ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<ChatCubit>(context).sendMessage(e);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e),
                        )))
                    .toList() ??
                [],
          ),
        );
      case "autocompite":
        return GestureDetector(
          onTap: () async {},
          child: Container(
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 0, bottom: 20),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: selectedOptions.isEmpty
                        ? Text(S.of(context).tap_options,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.placeholder))
                        : Text(
                            selectedOptions.join(", "),
                            style: TextStyle(
                                color: AppColor.text,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                  ),
                  IconButton(
                    onPressed: selectedOptions.isEmpty
                        ? null
                        : () {
                            BlocProvider.of<ChatCubit>(context)
                                .sendMessage(selectedOptions.join(", "));
                            setState(() {
                              selectedOptions = [];
                            });
                          },
                    icon: Container(
                      // padding: EdgeInsets.only(right: 24.w),
                      height: 32.h,
                      width: 32.h,
                      child: SvgPicture.asset(
                        "assets/images/sendFill.svg",
                        // height: 24.h
                        // semanticsLabel: 'Acme Logo'
                      ),
                    ),
                    // Icon(Icons.send, color:selectedOptions.isEmpty ? AppColor.placeholder: AppColor.primary,)
                  ),
                  SizedBox(
                    width: 24.w,
                  )
                ],
              )),
        );

      default:
        selectedOptions = [];
        return Container(
          // height: 60,
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 10,
                  offset: Offset(0, 18),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60.h,
                    child: TextField(
                      style: TextStyle(
                          color: AppColor.text,
                          height: 2.h,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none),
                      controller: _messageController,
                      onSubmitted: (s) {
                        if (s.trim().isEmpty) return;
                        setState(() {
                          _messageController.text = "";
                          BlocProvider.of<ChatCubit>(context).sendMessage(s);
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                            left: 15, top: 15, right: 0, bottom: 20),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: S.of(context).type_message,
                        hintStyle: TextStyle(color: AppColor.placeholder),
                      ),
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      String s = _messageController.text;
                      if (s.trim().isEmpty) return;
                      setState(() {
                        _messageController.text = "";
                        BlocProvider.of<ChatCubit>(context).sendMessage(s);
                      });
                    },
                    child: Container(
                      // padding: EdgeInsets.only(right: 24.w),
                      height: 32.h,
                      width: 32.h,
                      child: SvgPicture.asset(
                        "assets/images/sendFill.svg",
                        // height: 24.h
                        // semanticsLabel: 'Acme Logo'
                      ),
                    ),
                    // Container(margin: EdgeInsets.symmetric(horizontal: 10) ,
                    //   height: 30, width:  30,
                    //   decoration:  const BoxDecoration(color: AppColor.primary, shape:  BoxShape.circle),
                    //   child:
                    //
                    //   Icon(Icons.arrow_upward_sharp, color: AppColor.text2,),
                    // ),
                  ),
                ),
                SizedBox(
                  width: 24.w,
                )
              ],
            ),
          ),
        );
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
