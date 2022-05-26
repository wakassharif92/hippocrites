import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/api/APIHandler.dart';
import 'package:hmd_chatbot/services/storage/Storage.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class ChatState {

  ChatState(
      {required this.messages,
      this.options,
      this.inputType,
      this.questionType});

  List<Message> messages;
  List<String>? options;
  String? questionType;
  String? inputType;

  @override
  String toString() {
    return "messages: $messages, options: $options, inputType: $inputType, quetionType: $questionType";
  }
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.storageFactory, required this.apiFactory})
      : super(ChatState(
          messages: storageFactory.getStorage().messages,
        ));

  StorageFactory storageFactory;
  APIFactory apiFactory;

  sendMessage(
    String text,
  ) async {
    Storage s = storageFactory.getStorage();

    s.saveMessage(
        message: Message(
            id: s.lastMessageId + 1,
            fromUser: true,
            dateTime: DateTime.now(),
            type: Message.NORMAL_TYPE)
          ..text = text);
    emit(ChatState(
        messages: storageFactory.getStorage().messages,
        options: state.options,
        questionType: state.questionType,
        inputType: state.inputType));

    var ans = await apiFactory.getHandler().sendMessage(
        token: s.token!,
        userData: s.userData!,
        message: text,
        questionType: state.questionType);

    if(ans.questionType=="age") {
      ans = await _sendHiddenMessage(_dateFormat(s.userData!.birthdayDate), "age");
    }

    if(ans.questionType=="gender") {
      ans = await _sendHiddenMessage(s.userData!.sex, "gender");
    }


    if (ans.httpStatus == 200) {
        

      for (var element in ans.messages) {
        s.saveMessage(message: Message.fromMap(s.lastMessageId + 1, element));
      }
      emit(ChatState(
          messages: storageFactory.getStorage().messages,
          options: ans.options,
          questionType: ans.questionType,
          inputType: ans.inputType));
    }
  }

   _sendHiddenMessage(String message, String? questionType)async{
    var s = storageFactory.getStorage();
    var ans = await apiFactory.getHandler().sendMessage(
        token: s.token!,
        userData: s.userData!,
        message: message,
        questionType: questionType);
    return ans;
  }

  String _dateFormat(DateTime d)=>"${d.year}-${d.month<10?"0":""}${d.month}-${d.day<10?"0":""}${d.day}";

  initChat() async {
    var s = storageFactory.getStorage();
    var ans = await apiFactory
        .getHandler()
        .initChat(token: s.token!, userData: s.userData!);
    if (ans.httpStatus == 200) {
      s.saveMessage(
          message: Message(
              id: s.lastMessageId + 1,
              fromUser: true,
              dateTime: DateTime.now(),
              type: Message.SEPARATOR_TYPE));
      for (var element in ans.messages) {
        s.saveMessage(message: Message.fromMap(s.lastMessageId + 1, element));
      }
      emit(ChatState(
          messages: storageFactory.getStorage().messages,
          options: ans.options,
          questionType: ans.questionType,
          inputType: ans.inputType));
    }
  }

  int? findMessage(String search){
    search=search.trim();
    if(search.length<3) return null;
    var messages = storageFactory.getStorage().messages;
    for(var i = messages.length-1; i>=0; i--) {
      if(messages[i].text?.contains(search) ?? false) {

        return messages.length-i-1;
      }
    }
      return null;

  }
}
