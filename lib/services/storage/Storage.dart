import 'package:hmd_chatbot/models/Message.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:hmd_chatbot/models/current_screen.dart';

abstract class Storage {
  Future init();

  bool get loggedIn;

  String? get token;

  UserData? get userData;

  updateUserData({required UserData userData});

  List<Message> get messagesAAQ;
  List<Message> get messagesMAD;

  saveMessageMAD({required Message message});
  saveMessageAAQ({required Message message});

  int get lastMessageIdAAQ;
  int get lastMessageIdMAD;

  String get getCurrentScreen;

  clearAAQ();
  clearMAD();

  saveCurrentScreen({required CurrentScreen screen});

  logIn({required UserData userData, required String token});

  logOut();
}
