import 'package:ac_students/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/data/providers_data.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/providers/images.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/messages.dart';

class ChatSendItem extends StatefulWidget {
  final TextEditingController? msg;
  final ScrollController? controller;

  const ChatSendItem({Key? key, this.msg, this.controller}) : super(key: key);

  @override
  State<ChatSendItem> createState() => _ChatSendItemState();
}

class _ChatSendItemState extends State<ChatSendItem> {
  @override
  Widget build(BuildContext context) {
    final messagesProvider = Provider.of<Messages>(context, listen: false);
    final size = MediaQuery.of(context).size;
    TextEditingController msg = TextEditingController();
    // final box = GetStorage();
    final lan = Provider.of<LanguageProvider>(context);
    final usr = Provider.of<User>(context);

    return Container(
      color: primaryClr.withOpacity(0.6),
      height: size.height * 0.066,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: msg,
              style: TextStyle(color: secondaryClr),
              cursorColor: secondaryClr,
              cursorHeight: 20,
              decoration: InputDecoration(
                labelText: lan.get('Message'),
                labelStyle: TextStyle(fontSize: 14, color: secondaryClr),
                hintStyle: TextStyle(color: secondaryClr),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: secondaryClr, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: secondaryClr, width: 1),
                ),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: secondaryClr,
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            child: IconButton(
              onPressed: () async{
                if (msg.text.isEmpty) {
                } else {
                 await messagesProvider.addMessage(
                      context: context,
                      message: msg.text,
                      user: usr.userName ?? 'null',
                      userImg: usr.userImage ?? 1,
                      department: usr.userDep ?? 0,
                      year: usr.userYear??0,
                      userId: usr.userId??''
                  );

                  msg.clear();
                  setState(() {
                    widget.controller!
                        .jumpTo(widget.controller!.position.maxScrollExtent);
                  });
                }
              },
              icon: Icon(
                Icons.send,
                size: 18,
                color: primaryClr,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
