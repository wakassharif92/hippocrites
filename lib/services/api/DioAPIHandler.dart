import 'package:dio/dio.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:hmd_chatbot/services/api/APIHandler.dart';

class DioAPIHandler implements APIHandler {
  late Dio dio;

  @override
  Future init(String baseUrl) async {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    dio = Dio(options);
  }

  @override
  Future<LogInResponse> logIn({
    required String email,
    required String password,
  }) async {
    Response resp;
    try {
      resp = await dio.post("auth/email/login",
          data: {"email": email, "password": password});
      return LogInResponse(200,
          userData: UserData.fromMap(resp.data["data"]["user"]),
          token: resp.data["data"]["token"]["access_token"]);
    } on DioError catch (e) {
      print(e.response);
      return LogInResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"]);
    }
  }

  @override
  Future<SignInResponse> signIn(
      {required String email,
      required String password,
      required String sex,
      required DateTime birthDate}) async {
    Response resp;
    try {
      resp = await dio.post(
        "auth/email/register",
        data: {
          "email": email,
          "password": password,
          "sex": sex,
          "birthdaydate":
              "${birthDate.year}-${birthDate.month}-${birthDate.day}"
        },
      );
      return SignInResponse(
        200,
      );
    } on DioError catch (e) {
      return SignInResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"] ??
              e.response?.data["error"]?["infoMessage"]);
    }
  }

  @override
  Future<MessageResponse> sendMessage(
      {required String token,
      required UserData userData,
      required String message,
      String? questionType}) async {
    Response resp;
    try {
      resp = await dio.post("chat/send-message",
          data: {
            "userID": userData.userID,
            "message": message,
            "questionType": questionType
          },
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return MessageResponse(200,
          messages: resp.data["data"]["messageData"]["messages"]
                  ?.cast<Map<String, dynamic>>() ??
              [],
          inputType: resp.data["data"]["messageData"]["inputType"],
          options: resp.data["data"]["messageData"]["options"]?.cast<String>(),
          questionType: resp.data["data"]["messageData"]["questionType"]);
    } on DioError catch (e) {
      return MessageResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"] ??
              e.response?.data["error"]?["infoMessage"]);
    }
  }

  @override
  Future<MessageResponse> initChat(
      {required String token, required UserData userData}) async {
    Response resp;
    try {
      resp = await dio.post("chat/init",
          data: {
            "userID": userData.userID,
          },
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return MessageResponse(200,
          messages: resp.data["data"]["messageData"]["messages"]
                  ?.cast<Map<String, dynamic>>() ??
              [],
          inputType: resp.data["data"]["messageData"]["inputType"],
          options: resp.data["data"]["messageData"]["options"]?.cast<String>(),
          questionType: resp.data["data"]["messageData"]["questionType"]);
    } on DioError catch (e) {
      return MessageResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"] ??
              e.response?.data["error"]?["infoMessage"]);
    }
  }

  @override
  Future<PasswordRestoreResponse> restorePassword(
      {required String email}) async {
    Response resp;
    try {
      resp = await dio.get(
        "auth/email/forgot-password/$email",
      );

      return PasswordRestoreResponse(
        200,
      );
    } on DioError catch (e) {
      // print(e.response);
      return PasswordRestoreResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"] ??
              e.response?.data["error"]?["infoMessage"]);
    }
  }

  @override
  Future<UpdatePasswordResponse> changePassword(
      {required String email,
      required String currentPass,
      required String newPass,
      required String token}) async {
    Response resp;
    try {
      resp = await dio.post("auth/email/change-password",
          data: {"currentPassword":currentPass,"newPassword":newPass,"email":email},
          options: Options(headers: {"Authorization": "Bearer $token"}));


      return UpdatePasswordResponse(200);

    } on DioError catch (e) {
      return UpdatePasswordResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"] ??
              e.response?.data["error"]?["infoMessage"]);
  }

  }

  @override
  Future<UpdateProfileResponse> updateProfile(
      {required UserData userData, required String token}) async {
    Response resp;
    try {
      resp = await dio.post("users/profile/update",
          data: userData.toMap(),
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return UpdateProfileResponse(200,
          userData: UserData.fromMap(resp.data["data"]["data"]));
    } on DioError catch (e) {
      return UpdateProfileResponse(e.response?.statusCode,
          error: e.response?.data["error"]?["message"] ??
              e.response?.data["error"]?["infoMessage"]);
    }
  }
}
