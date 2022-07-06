import 'package:hmd_chatbot/models/UserData.dart';

class LogInResponse {
  LogInResponse(this.httpStatus, {this.userData, this.token, this.error})
      : assert((userData != null && token != null) || error != null);
  UserData? userData;
  String? token;
  String? error;
  int? httpStatus;
}

class SignInResponse {
  SignInResponse(this.httpStatus, {this.error});

  String? error;
  int? httpStatus;
}

class PasswordRestoreResponse {
  PasswordRestoreResponse(this.httpStatus, {this.error});

  String? error;
  int? httpStatus;
}

class MessageResponse {
  MessageResponse(this.httpStatus,
      {this.error,
      this.messages = const [],
      this.options,
      this.questionType,
      this.inputType})
      : assert(error != null || messages.isNotEmpty);

  List<Map<String, dynamic>> messages;
  List<String>? options;
  String? questionType;
  String? inputType;
  String? error;
  int? httpStatus;
}

class UpdateProfileResponse {
  UpdateProfileResponse(this.httpStatus, {this.userData, this.error})
      : assert(userData != null || error != null);
  UserData? userData;
  String? error;
  int? httpStatus;
}

class UpdatePasswordResponse {
  UpdatePasswordResponse(this.httpStatus, { this.error});
  String? error;
  int? httpStatus;
}

abstract class APIHandler {
  Future init(String baseUrl);

  Future<LogInResponse> logIn({
    required String email,
    required String password,
  });

  Future<SignInResponse> signIn(
      {required String email,
      required String password,
      required String sex,
      required DateTime birthDate});

  Future<MessageResponse> sendMessage(
      {required String token,
      required UserData userData,
      required String message,
      String? questionType});

  Future<MessageResponse>   initChat({
    required String token,
    required UserData userData,
  });

  Future<PasswordRestoreResponse> restorePassword({required String email});

  Future<UpdatePasswordResponse> changePassword(
      {required String email,
      required String currentPass,
      required String newPass,
      required String token});

  Future<UpdateProfileResponse> updateProfile(
      {required UserData userData, required String token});
}
