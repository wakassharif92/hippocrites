import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

class AuthCubit extends Cubit<bool> {
  AuthCubit({required this.storageFactory, required this.apiFactory})
      : super(storageFactory.getStorage().loggedIn);

  StorageFactory storageFactory;
  APIFactory apiFactory;

  logOut() {
    storageFactory.getStorage().logOut();
    emit(false);}

  Future<String?> logIn(

      {required String email, required String password}) async {

    var res = await apiFactory
        .getHandler()
        .logIn(email: email, password: password);

    if (res.httpStatus != 200) {
      return res.error ?? "an error occurred";
    } else {
      StorageFactory()
          .getStorage()
          .logIn(userData: res.userData!, token: res.token!);
      emit(true);

    }
  }

  Future<String?> signIn(
      {required String email,
      required String password,
      required String sex,
      required DateTime birthDate}) async {

    var res = await apiFactory
        .getHandler()
        .signIn(email: email, password: password, sex: sex, birthDate: birthDate);
    if (res.httpStatus != 200) {
      return res.error ?? "an error occurred";
    }

  }

  Future<String?>restorePassword({required String email})async{

    var res = await apiFactory
        .getHandler()
        .restorePassword(email: email);
    if (res.httpStatus != 200) {
      return res.error ?? "an error occurred";
    }
  }
}
