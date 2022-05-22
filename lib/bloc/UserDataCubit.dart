import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class UserDataCubit extends Cubit<UserData> {
  UserDataCubit({required this.storageFactory, required this.apiFactory})
      : super(storageFactory.getStorage().userData!);

  StorageFactory storageFactory;
  APIFactory apiFactory;

  Future<String?> updateProfile(
      {required String name,
      required DateTime birthdayDate,
      required String sex}) async {
    var s = storageFactory.getStorage();
    var res = await apiFactory.getHandler().updateProfile(
        userData: s.userData!
            .copyWith(name: name, birthdayDate: birthdayDate, sex: sex),
        token: s.token!);

    if (res.httpStatus != 200) {
      return res.error ?? "an error occurred";
    } else {
     s.updateUserData(userData: res.userData!);
     emit(s.userData!);
    }

  }

  Future<String?> changePass({required String currentPass, required String newPass,})async{
    var s = storageFactory.getStorage();

    var res = await apiFactory.getHandler().changePassword(
        email: s.userData!.email,
        currentPass: currentPass,
        newPass: newPass,
        token: s.token!);

    if (res.httpStatus != 200) {
      return res.error ?? "an error occurred";
    }


  }
}
