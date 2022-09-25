import 'package:ac_students/admin/providers/admin_provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/providers/files.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/subjects.dart';
import 'package:ac_students/student/models/subject.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsList extends StatefulWidget {
  const SubjectsList({Key? key}) : super(key: key);

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final subjectsProvider = Provider.of<Subjects>(context);
    final filesProvider = Provider.of<Files>(context);
    final admin = Provider.of<AdminProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate:
      const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 155,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 0,
      ),
      itemBuilder: (context, index) {
        List<Subject> subjects = subjectsProvider.subjects
            .where((element) =>
        element.department == admin.selectedDep)
            .toList();
        final varSubject = subjects[index];
        return MaterialButton(
          onPressed: () {
            setState(() {
              admin.selectSubject(
                index,
              );
              admin.changeSubjectId(subjects
                  .firstWhere(
                    (
                    element,
                    ) =>
                element.id == varSubject.id,
              )
                  .id!
                  .toInt());
            });
          },
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.4,
            padding: edge5,
            margin: edge10,
            child: Center(
              child: FittedBox(
                child: Text(
                  varSubject.name.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    backgroundColor: secondaryClr,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: primaryClr,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                    0.2,
                  ),
                  BlendMode.dstATop,
                ),
                image: const AssetImage(
                  'images/subject.png',
                ),
              ),
              color: index != admin.selectedSubject
                  ? primaryClr
                  : secondaryClr,
              borderRadius: BorderRadius.circular(
                25,
              ),
            ),
          ),
        );
      },
      itemCount: subjectsProvider.subjects
          .where(
            (element) =>
        element.department == admin.selectedDep,
      )
          .length,
    );
  }
}
