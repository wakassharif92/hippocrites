import 'package:hive/hive.dart';

part 'Message.g.dart';

@HiveType(typeId: 1)
class Message {
  static const SEPARATOR_TYPE = "separator";
  static const NORMAL_TYPE = "normal";

  @HiveField(0)
  int id;

  @HiveField(1)
  String? text;

  @HiveField(2)
  bool fromUser;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  String type;

  @HiveField(5)
  String? description;

  @HiveField(6)
  String? prevention;

  @HiveField(7)
  String? treatments;

  @HiveField(8)
  String? title;

  @HiveField(9)
  int? probability;

  @HiveField(10)
  String? publications;

  factory Message.fromMap(int id, Map map) => Message(
      id: id, fromUser: false, dateTime: DateTime.now(), type: NORMAL_TYPE)
    ..text = map["message"]
    ..title = map["title"]
    ..description = map["description"]
    ..prevention = map["prevention"]
    ..treatments = map["treatments"]
    ..probability = map["probability"]
    ..publications = map["publications"];

  Message(
      {required this.id,
      required this.fromUser,
      required this.dateTime,
      required this.type});
}
