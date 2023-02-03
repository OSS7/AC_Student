import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/core/widgets/loading_circle.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/user/chat/providers/chat_provider.dart';
import 'package:ac_students/features/user/chat/widgets/chat_item.dart';
import 'package:ac_students/features/user/chat/widgets/chat_send_item.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset1;
  Animation<Offset>? offset2;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    offset1 = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.easeInOut));
    offset2 = Tween<Offset>(end: Offset.zero, begin: const Offset(-1.0, 0.0))
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.easeInOut));
    _animationController?.forward();
    final usr = Provider.of<UserProvider>(context, listen: false);
    Provider.of<ChatProvider>(context, listen: false)
        .startLiveQuery(usr.userDep ?? 1, usr.userYear ?? 1);
  }

  bool isMe = false;
  TextEditingController msg = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final box = GetStorage();
    final messageProvider = Provider.of<ChatProvider>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context);
    final usr = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Directionality(
        textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          appBar: AppBarWidget(
            child: IconButton(
              icon: const Icon(Icons.swipe_down_sharp),
              onPressed: () {
                _controller.jumpTo(_controller.position.maxScrollExtent);
              },
            ),
            txt: lan.get('ChatLabel'),
          ),
          backgroundColor: primaryClr,
          drawer: const DrawerWidget(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // flex: 1,
                child: FutureBuilder<List<ParseObject>>(
                    future: messageProvider.getMessages(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const LoadingCircle();
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  "Sorry, There is Error or there is no messages yet.",
                                  style: TextStyle(color: secondaryClr)),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const LoadingCircle();
                          } else {
                            List<ParseObject> varList = messageProvider.messages
                                .where((element) =>
                                    element.get<int>('user_year') ==
                                        usr.userYear &&
                                    element.get<int>('user_department') ==
                                        usr.userDep)
                                .toList();
                            return Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      controller: _controller,
                                      // reverse: true,
                                      itemCount: varList.length,
                                      itemBuilder: (context, i) {
                                        //*************************************
                                        final varChat = varList[i];
                                        final varTitle = messageProvider
                                                .messages[i]
                                                .get<String>('message') ??
                                            ' null';
                                        DateTime varDate =
                                            varChat.get('createdAt') ??
                                                DateTime.now();
                                        final varName =
                                            varChat.get<String>('user_name') ??
                                                'null';
                                        final varImg =
                                            varChat.get<int>('user_img') ?? 2;
                                        final varId =
                                            varChat.get<String>('user_id') ??
                                                '';

                                        bool isMe = varId == usr.userId;
                                        //*************************************
                                        return SlideTransition(
                                          position: isMe ? offset1! : offset2!,
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: ChatItem(
                                                isMe: isMe,
                                                varId: varId,
                                                varName: varName,
                                                varTitle: varTitle,
                                                varDate: varDate,
                                                varImg: varImg,
                                              )),
                                        );
                                      }),
                                ),
                              ],
                            );
                          }
                      }
                    }),
              ),
              (usr.enableChat ?? true) || (usr.isAdmin ?? false)
                  ? ChatSendItem(
                      msg: msg,
                      controller: _controller,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
