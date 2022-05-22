import 'dart:math';

import 'package:hive/hive.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:hmd_chatbot/services/storage/Storage.dart';
import 'package:path_provider/path_provider.dart';

class HiveStorage implements Storage{

  bool _initDone=false;

  @override
  init() async {
    if (_initDone) return;
    String savePath = (await getApplicationDocumentsDirectory()).path;

    Hive.init(savePath);
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(MessageAdapter());


    Box config = await Hive.openBox("config");
    await Hive.openBox<Message>("messages");

    _initDone = true;
  }

  @override
  String? get token => Hive.box("config").get("token");

  @override
  UserData? get userData => Hive.box("config").get("userData") as UserData?;

  @override
  updateUserData({required UserData userData}) {
    Hive.box("config").put("userData", userData);
  }

  @override
  bool get loggedIn => Hive.box("config").get("loggedIn", defaultValue: false);

  @override
  logIn({required UserData userData, required String token}) {
    Hive.box("config").put("userData", userData);
    Hive.box("config").put("token", token);
    Hive.box("config").put("loggedIn", true);
  }

  @override
  logOut() {
    Hive.box("config").clear();
    Hive.box<Message>("messages").clear();
  }

  @override
  List<Message> get messages => Hive.box<Message>("messages").values.toList();

  int _getLastMessageId(){
    int res = 0;
    for(int i in Hive.box<Message>("messages").keys) {
      if(i>res) {
        res=i;
      }
    }
    return res;
  }

  @override
  saveMessage({required Message message}) {
    Hive.box<Message>("messages").put(message.id, message);
  }

  @override
  int get lastMessageId => _getLastMessageId();


}