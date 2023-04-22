import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/core/utils/widgets/loading_circle.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/student/chat/providers/chat_provider.dart';
import 'package:ac_students/features/student/chat/widgets/chat_item.dart';
import 'package:ac_students/features/student/chat/widgets/chat_listview.dart';
import 'package:ac_students/features/student/chat/widgets/chat_send_item.dart';
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

  TextEditingController msg = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
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
                child: ChatListView(
                  controller: _controller,
                ),
              ),
              Visibility(
                visible: (usr.enableChat ?? true) || (usr.isAdmin ?? false),
                child: ChatSendItem(
                  msg: msg,
                  controller: _controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
