import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/user/chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  final bool? isMe;
  final DateTime? varDate;
  final String? varTitle;
  final String? varId;
  final String? varName;
  final int? varImg;

  const ChatItem(
      {Key? key,
      this.isMe,
      this.varId,
      this.varDate,
      this.varTitle,
      this.varName,
      this.varImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final messageProvider = Provider.of<ChatProvider>(context);
    final usr = Provider.of<UserProvider>(context);

    return InkWell(
      onLongPress: () {
        usr.isAdmin ?? false
            ? showDialog(
                context: context,
                builder: (ctx) {
                  return SizedBox(
                    //margin: EdgeInsets.all(20),
                    width: size.width * 0.5,
                    height: size.height * 0.3,
                    child: AlertDialog(
                      content: const Text(
                          'Are you sure you want to delete this Message?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            messageProvider.deleteMessage(context, varId ?? '');
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    ),
                  );
                })
            : isMe!
                ? showDialog(
                    context: context,
                    builder: (ctx) {
                      return SizedBox(
                        //margin: EdgeInsets.all(20),
                        width: size.width * 0.5,
                        height: size.height * 0.3,
                        child: AlertDialog(
                          content: const Text(
                              'Are you sure you want to delete this Message?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                messageProvider.deleteMessage(
                                    context, varId ?? '');
                                Navigator.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    })
                : null;
      },
      child: Row(
        mainAxisAlignment:
            isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe!
              ? Container()
              : Container(
                  height: size.height * 0.12,
                  width: 3,
                  color: secondaryClr,
                ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(1),
              width: size.width * 0.95,
              color: isMe! ? secondaryClr : primaryClr,
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Row(
                    mainAxisAlignment:
                        isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      !isMe!
                          ? CircleAvatar(
                              child: Image.asset(
                                  'images/avatars/${varImg ?? 2}.png'),
                            )
                          : Container(),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(varName.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: isMe! ? primaryClr : secondaryClr,
                              fontSize: 15)),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      isMe!
                          ? CircleAvatar(
                              child: Image.asset(
                                  'images/avatars/${varImg ?? 2}.png'),
                            )
                          : Container(),
                    ],
                  ),
                  Divider(
                    height: 20,
                    color: isMe! ? primaryClr : secondaryClr,
                  ),
                  SelectableText('$varTitle \n ',
                      style: TextStyle(
                          color: isMe! ? primaryClr : secondaryClr,
                          fontSize: 20)),
                  Text(
                      DateTime.now().day != varDate!.day
                          ? '${varDate!.month}/${varDate!.day}, ${varDate!.hour}:${varDate!.minute} '
                          : 'today, ${varDate!.hour}:${varDate!.minute}',
                      style: TextStyle(
                          color: isMe! ? primaryClr : secondaryClr,
                          fontSize: 12)),
                ],
              ),
            ),
          ),
          isMe!
              ? Container(
                  height: size.height * 0.12,
                  width: 3,
                  color: secondaryClr,
                )
              : Container(),
        ],
      ),
    );
  }
}
