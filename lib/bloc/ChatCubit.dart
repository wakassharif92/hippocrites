import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:hmd_chatbot/models/db/databaseHelper.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';

import 'package:hmd_chatbot/services/storage/Storage.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class ChatState {
  ChatState(
      {required this.messages,
      this.options,
      this.inputType,
      this.questionType,
      this.loading = false});

  List<Message> messages;
  List<String>? options;
  String? questionType;
  String? inputType;
  bool loading = false;

  @override
  String toString() {
    return "messages: $messages, options: $options, inputType: $inputType, quetionType: $questionType";
  }
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.storageFactory,
    required this.apiFactory,
  }) : super(ChatState(
          messages:
              storageFactory.getStorage().getCurrentScreen == "Ask a question"
                  ? storageFactory.getStorage().messagesAAQ
                  : storageFactory.getStorage().messagesMAD,
        ));

  StorageFactory storageFactory;
  APIFactory apiFactory;

  sendMessage(String text) async {
    Storage s = storageFactory.getStorage();

    if (s.getCurrentScreen == "Ask a question") {
      s.saveMessageAAQ(
          message: Message(
              id: s.lastMessageIdAAQ + 1,
              fromUser: true,
              dateTime: DateTime.now(),
              type: Message.NORMAL_TYPE)
            ..text = text);
    } else {
      s.saveMessageMAD(
          message: Message(
              id: s.lastMessageIdMAD + 1,
              fromUser: true,
              dateTime: DateTime.now(),
              type: Message.NORMAL_TYPE)
            ..text = text);
    }

    if (s.getCurrentScreen == "Ask a question") {
      emit(ChatState(
          messages: storageFactory.getStorage().messagesAAQ,
          options: state.options,
          questionType: state.questionType,
          inputType: state.inputType,
          loading: true));
    } else {
      emit(ChatState(
          messages: storageFactory.getStorage().messagesMAD,
          options: state.options,
          questionType: state.questionType,
          inputType: state.inputType,
          loading: true));
    }
    var ans = await apiFactory.getHandler().sendMessage(
        token: s.token!,
        userData: s.userData!,
        message: text,
        questionType: state.questionType);
    emit(ChatState(
      loading: true,
      messages: state.messages,
      inputType: state.inputType,
      options: state.options,
    ));

    if (ans.questionType == "age") {
      ans = await _sendHiddenMessage(
          _dateFormat(s.userData!.birthdayDate), "age");
    }

    if (ans.questionType == "gender") {
      ans = await _sendHiddenMessage(s.userData!.sex, "gender");
    }

    if (ans.httpStatus == 200) {
      for (var element in ans.messages) {
        if (s.getCurrentScreen == "Ask a question") {
          s.saveMessageAAQ(
              message: Message.fromMap(s.lastMessageIdAAQ + 1, element));
        } else {
          s.saveMessageMAD(
              message: Message.fromMap(s.lastMessageIdMAD + 1, element));
        }
        // await saveMessage(element);
      }

      if (s.getCurrentScreen == "Ask a question") {
        emit(ChatState(
            messages: storageFactory.getStorage().messagesAAQ,
            options: ans.options,
            questionType: ans.questionType,
            inputType: ans.inputType,
            loading: false));
      } else {
        emit(ChatState(
            messages: storageFactory.getStorage().messagesMAD,
            options: ans.options,
            questionType: ans.questionType,
            inputType: ans.inputType,
            loading: false));
      }
    }
  }

  Future<void> saveMessage(response) async {
    final dbHelper = DatabaseHelper.instance;
    var userData = StorageFactory().getStorage().userData;
    var userId = userData?.userID ?? "";
    Map<String, dynamic> row = {
      DatabaseHelper.rh_user_id: userId,
      DatabaseHelper.rh_description: response != null ? response : ""
    };

    var resp = await dbHelper.insert(DatabaseHelper.tbl_results_history, row);
    print(resp);
  }

  _sendHiddenMessage(String message, String? questionType) async {
    var s = storageFactory.getStorage();
    var ans = await apiFactory.getHandler().sendMessage(
        token: s.token!,
        userData: s.userData!,
        message: message,
        questionType: questionType);
    return ans;
  }

  String _dateFormat(DateTime d) =>
      "${d.year}-${d.month < 10 ? "0" : ""}${d.month}-${d.day < 10 ? "0" : ""}${d.day}";

  initChat(String typeOfChat) async {
    var s = storageFactory.getStorage();

    var ans = await apiFactory
        .getHandler()
        .initChat(token: s.token!, userData: s.userData!);
    if (ans.httpStatus == 200) {
      if (s.getCurrentScreen == "Ask a question") {
        s.saveMessageAAQ(
            message: Message(
                id: s.lastMessageIdAAQ + 1,
                fromUser: true,
                dateTime: DateTime.now(),
                type: Message.SEPARATOR_TYPE));
      } else {
        s.saveMessageMAD(
            message: Message(
                id: s.lastMessageIdMAD + 1,
                fromUser: true,
                dateTime: DateTime.now(),
                type: Message.SEPARATOR_TYPE));
      }

      for (var element in ans.messages) {
        if (s.getCurrentScreen == "Ask a question") {
          s.saveMessageAAQ(
              message: Message.fromMap(s.lastMessageIdAAQ + 1, element));
        } else {
          s.saveMessageMAD(
              message: Message.fromMap(s.lastMessageIdMAD + 1, element));
        }
      }
      sendMessage(typeOfChat);
      //
      // emit(ChatState(
      //     messages: storageFactory.getStorage().messages,
      //     options: ans.options,
      //     questionType: ans.questionType,
      //     inputType: ans.inputType));
    }
  }

  int? findMessage(String search) {
    search = search.trim();
    if (search.length < 3) return null;
    var messages;
    if (storageFactory.getStorage().getCurrentScreen == "Ask a question") {
      messages = storageFactory.getStorage().messagesAAQ;
    } else {
      messages = storageFactory.getStorage().messagesMAD;
    }
    for (var i = messages.length - 1; i >= 0; i--) {
      if (messages[i].text?.contains(search) ?? false) {
        return messages.length - i - 1;
      }
    }
    return null;
  }
}
