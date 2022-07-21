import 'package:hive/hive.dart';

part 'current_screen.g.dart';

@HiveType(typeId: 2)
class CurrentScreen extends HiveObject {
  @HiveField(0)
  late String name;
}
