import 'package:hive/hive.dart';

part 'UserData.g.dart';

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  String userID;

  @HiveField(1)
  DateTime birthdayDate;

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;

  @HiveField(4)
  String sex;

  UserData(
      {required this.userID,
      required this.birthdayDate,
      required this.name,
      required this.email,
      required this.sex});

  Map<String, dynamic> toMap() => {
        "userID": userID,
        "birthdaydate": birthdayDate.toIso8601String(),
        "name": name,
        "email": email,
        "sex": sex
      };

  UserData copyWith(
          {String? userID,
          DateTime? birthdayDate,
          String? name,
          String? email,
          String? sex}) =>
      UserData(
          userID: userID ?? this.userID,
          birthdayDate: birthdayDate ?? this.birthdayDate,
          name: name ?? this.name,
          email: email ?? this.email,
          sex: sex ?? this.sex);

  factory UserData.fromMap(Map<String, dynamic> map) => UserData(
      userID: map["userID"],
      birthdayDate: DateTime.parse(map["birthdaydate"]),
      name: map["name"],
      email: map["email"],
      sex: map["sex"]);
}
