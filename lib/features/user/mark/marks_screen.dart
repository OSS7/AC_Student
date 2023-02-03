import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/features/user/mark/providers/marks_provider.dart';
import 'package:ac_students/features/user/mark/widgets/marks_item.dart';
import 'package:ac_students/features/user/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/constant.dart';
import '../../drawer/drawer.dart';

class MarksScreen extends StatefulWidget {
  const MarksScreen({Key? key}) : super(key: key);

  @override
  _MarksScreenState createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.decelerate));
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final markProvider = Provider.of<MarksProvider>(context, listen: false);
    final subjectProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
    final lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('MarksLabel').toString(),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: SlideTransition(
          position: offset!,
          child: markProvider.marks.isEmpty
              ? Center(
                  child: Text(lan.get('MarksEmpty').toString()),
                )
              : ListView.builder(
                  itemCount: markProvider.marks.length,
                  itemBuilder: (context, index) {
                    final varMark = markProvider.marks[index];
                    final varSubject = subjectProvider.subjects.firstWhere(
                        (element) => element.id == varMark.subjectId);
                    final varLink = varMark.link;
                    return MarksItem(
                      title: varSubject.name,
                      link: varLink,
                    );
                  }),
        ),
      ),
    );
  }
}
