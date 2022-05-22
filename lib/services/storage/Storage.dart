
import 'package:hmd_chatbot/models/Message.dart';
import 'package:hmd_chatbot/models/UserData.dart';

abstract class Storage{

  Future init();

  bool get loggedIn;

  String? get token;

  UserData? get userData;

  updateUserData({required UserData userData});

  List<Message> get messages;

  saveMessage({required Message message});

  int get lastMessageId;

  logIn({ required UserData userData, required String token});

  logOut();


}