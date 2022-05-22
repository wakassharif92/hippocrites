import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/ChatCubit.dart';
import 'package:hmd_chatbot/components/ChatMessage.dart';
import 'package:hmd_chatbot/components/OptionsDialog.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.itemScrollController}) : super(key: key,);
  final ItemScrollController itemScrollController;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).initChat();
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
                onTap: (){
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
                    return ChatMessage(message: e);
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

  Widget pickInput(BuildContext context, ChatState state) {
    switch (state.inputType) {
      case "button":
        selectedOptions= [];
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
          onTap: () async {
            await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (c) => OptionsDialog(
                      selected: selectedOptions,
                      options: state.options ?? [],
                    ));
            setState(() {});
          },
          child: Container(
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 0, bottom: 20),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: selectedOptions.isEmpty
                        ? Text(S.of(context).tap_options,
                            style: TextStyle(
                                fontSize: 18.0, color: AppColor.placeholder))
                        : Text(
                            selectedOptions.join(", "),
                            style: const TextStyle(
                                color: AppColor.text, fontSize: 18.0),
                          ),
                  ),
                  IconButton(onPressed: selectedOptions.isEmpty ?null :(){
                    BlocProvider.of<ChatCubit>(context).sendMessage(selectedOptions.join(", "));
                    setState(() {
                      selectedOptions=[];
                    });
                  }, icon: Icon(Icons.send, color:selectedOptions.isEmpty ? AppColor.placeholder: AppColor.primary,))
                ],
              )),
        );

      default:
        selectedOptions= [];
        return Container(
          height: 70,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: AppColor.text, fontSize: 18.0, decoration: TextDecoration.none),
                  controller: _messageController,
                  onSubmitted: (s) {
                    if(s.trim().isEmpty) return;
                    setState(() {
                      _messageController.text = "";
                      BlocProvider.of<ChatCubit>(context).sendMessage(s);
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, top: 15, right: 0, bottom: 20),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: S.of(context).type_message,
                    hintStyle: TextStyle(color: AppColor.placeholder),
                  ),
                  textInputAction: TextInputAction.send,
                ),
              ),
              GestureDetector(
                onTap: (){
                  String s = _messageController.text;
                  if(s.trim().isEmpty) return;
                  setState(() {
                    _messageController.text = "";
                    BlocProvider.of<ChatCubit>(context).sendMessage(s);
                  });
                },
                child: Container(margin: EdgeInsets.symmetric(horizontal: 10) ,
                  height: 30, width:  30,
                  decoration:  const BoxDecoration(color: AppColor.primary, shape:  BoxShape.circle),
                  child: Icon(Icons.arrow_upward_sharp, color: AppColor.text2,),
                ),
              )
            ],
          ),
        );
    }
  }
}
