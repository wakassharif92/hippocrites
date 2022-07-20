import 'package:hmd_chatbot/services/storage/HiveStorage.dart';
import 'package:hmd_chatbot/services/storage/Storage.dart';

class StorageFactory {
  static Storage? storageInstance;

  Storage getStorage() {
    return storageInstance == null
        ? storageInstance = HiveStorage()
        : storageInstance!;
  }
}
