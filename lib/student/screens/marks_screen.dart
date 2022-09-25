import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/marks_item.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/marks.dart';
import 'package:ac_students/providers/subjects.dart';
import '../../data/constant.dart';
import '../widgets/drawer.dart';

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
    final markProvider = Provider.of<Marks>(context, listen: false);
    final subjectProvider = Provider.of<Subjects>(context, listen: false);
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
