import 'package:ac_students/features/student/subject/subjects/widgets/subject_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../auth/providers/user_provider.dart';
import '../providers/subjects_provider.dart';

class SubjectsSubjectsListView extends StatefulWidget {
  const SubjectsSubjectsListView({Key? key}) : super(key: key);

  @override
  State<SubjectsSubjectsListView> createState() =>
      _SubjectsSubjectsListViewState();
}

class _SubjectsSubjectsListViewState extends State<SubjectsSubjectsListView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.decelerate));
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subjectsProvider = Provider.of<SubjectsProvider>(context);
    final usr = Provider.of<UserProvider>(context);

    return Expanded(
      child: SlideTransition(
        position: offset!,
        child: SizedBox(
          width: size.width,
          // height: size.height  * 0.8,
          child: GridView.builder(
            itemCount: subjectsProvider
                .subjectsForSubjectsScreen(
                    userYear: usr.userYear ?? 1, userDep: usr.userDep ?? 1)
                .length,
            itemBuilder: (context, index) {
              final varSubject = subjectsProvider.subjectsForSubjectsScreen(
                  userYear: usr.userYear ?? 1,
                  userDep: usr.userDep ?? 1)[index];

              final varTitle = varSubject.name;
              final varId = varSubject.id;
              return Center(
                child: SubjectItem(
                  varTitle ?? '',
                  '/FilesScreen',
                  varId ?? 0,
                  false,
                ),
              );
            },
            padding: edge10,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          ),
        ),
      ),
    );
  }
}
