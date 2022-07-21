import 'dart:math';

import 'package:hive/hive.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:hmd_chatbot/models/current_screen.dart';
import 'package:hmd_chatbot/services/storage/Storage.dart';
import 'package:path_provider/path_provider.dart';

class HiveStorage implements Storage {
  bool _initDone = false;

  @override
  init() async {
    if (_initDone) return;
    String savePath = (await getApplicationDocumentsDirectory()).path;
    Hive.init(savePath);
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(CurrentScreenAdapter());

    Box config = await Hive.openBox("config");
    await Hive.openBox<Message>("messages_mad");
    await Hive.openBox<Message>("messages_aaq");
    await Hive.openBox<CurrentScreen>("current_screen");
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
    Hive.box<Message>("messages_aaq").clear();
    Hive.box<Message>("messages_mad").clear();
  }

  @override
  List<Message> get messagesAAQ =>
      Hive.box<Message>("messages_aaq").values.toList();

  @override
  List<Message> get messagesMAD =>
      Hive.box<Message>("messages_mad").values.toList();

  @override
  String get getCurrentScreen {
    final k = Hive.box<CurrentScreen>("current_screen");
    return k.values.last.name;
  }

  @override
  saveCurrentScreen({required CurrentScreen screen}) {
    Hive.box<CurrentScreen>("current_screen").put(0, screen);
  }

  int _getLastMessageIdAAQ() {
    int res = 0;
    for (int i in Hive.box<Message>("messages_aaq").keys) {
      if (i > res) {
        res = i;
      }
    }
    return res;
  }

  int _getLastMessageIdMAD() {
    int res = 0;
    for (int i in Hive.box<Message>("messages_mad").keys) {
      if (i > res) {
        res = i;
      }
    }
    return res;
  }

  @override
  saveMessageAAQ({required Message message}) {
    Hive.box<Message>("messages_aaq").put(message.id, message);
  }

  @override
  saveMessageMAD({required Message message}) {
    Hive.box<Message>("messages_mad").put(message.id, message);
  }

  @override
  int get lastMessageIdAAQ => _getLastMessageIdAAQ();

  @override
  int get lastMessageIdMAD => _getLastMessageIdMAD();

  // ignore: todo
  // TODO: implement messages
  List<Message> get messages => throw UnimplementedError();
}
