import 'package:flutter/material.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:hmd_chatbot/services/storage/Storage.dart';

import '../../components/ChatMessage.dart';

class ChatHistory extends StatefulWidget {
  const ChatHistory({Key? key}) : super(key: key);

  @override
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  var history = [];

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: history.isEmpty
                ? const Center(child: Text("No History Available "))
                : ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      // print(history[index].runtimeType );
                      // var m = history[index]["rh_description"];
                      // print(m[]);
                      // print(json.encode(m));
                      // print(m.runtimeType );
                      // var test = json.decode(m);

                      var m = history;
                      var e = m[m.length - index - 1];
                      return Column(
                        children: [
                          ChatMessage(e, "selectedOptions"),
                        ],
                      );
                    },
                    itemCount: history.length,
                  )));
  }

  getHistory() async {
    // final dbHelper = DatabaseHelper.instance;
    // var userData = StorageFactory().getStorage().userData;
    // var userId = userData?.userID ?? "";
    // Map<String, dynamic> row = {
    //   DatabaseHelper.rh_title:"The titel 1"??"",
    //   DatabaseHelper.rh_user_id: userId,
    //   DatabaseHelper.rh_type: "The tyoe 1"??"",
    //   DatabaseHelper.rh_details:"The det 1"??"",
    // };
    //
    // await dbHelper.insert(DatabaseHelper.tbl_results_history, row);

    // var resl = await dbHelper.selectRowWhere(DatabaseHelper.tbl_results_history,
    //     "${DatabaseHelper.rh_user_id}='${userId}'");
    // // print(resl[0]);
    // print(resl);
    StorageFactory storageFactory = StorageFactory();
    Storage s = storageFactory.getStorage();
    setState(() {
      history = s.messagesAAQ;
    });
  }
}
