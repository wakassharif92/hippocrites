import 'package:hmd_chatbot/services/api/APIHandler.dart';
import 'package:hmd_chatbot/services/api/DioAPIHandler.dart';



class APIFactory{

  static APIHandler? handlerInstance;

  APIHandler getHandler(){
    return handlerInstance==null ? handlerInstance = DioAPIHandler() : handlerInstance!;
  }

}