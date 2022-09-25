import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/loading_circle.dart';
import 'package:ac_students/student/widgets/subject_item.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/subjects.dart';
import 'package:ac_students/providers/user.dart';

class HomeSubjectsWidget extends StatefulWidget {
  const HomeSubjectsWidget({Key? key}) : super(key: key);

  @override
  State<HomeSubjectsWidget> createState() => _HomeSubjectsWidgetState();
}

class _HomeSubjectsWidgetState extends State<HomeSubjectsWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subjectsProvider = Provider.of<Subjects>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context);
    final usr = Provider.of<User>(context);

    return Container(
      padding: const EdgeInsets.only(top: 20),
      width: size.width * 1,
      height: size.height * 0.30,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: subjectsProvider.isFirstSem ? secondaryClr : primaryClr,
                onPressed: () {
                  setState(() {
                    subjectsProvider.homeChangeSem();
                  });
                },
                child: Text(
                  lan.get('Semester1').toString(),
                  style: TextStyle(
                      color: subjectsProvider.isFirstSem
                          ? primaryClr
                          : secondaryClr),
                ),
              ), // زر عند الضغط عليه نظهر مواد الفصلل الاول
              MaterialButton(
                  color:
                      !subjectsProvider.isFirstSem ? secondaryClr : primaryClr,
                  onPressed: () {
                    setState(() {
                      subjectsProvider.homeChangeSem();
                    });
                  },
                  child: Text(
                    lan.get('Semester2').toString(),
                    style: TextStyle(
                        color: !subjectsProvider.isFirstSem
                            ? primaryClr
                            : secondaryClr),
                  )),// زر عند الضغط عليه نظهر مواد الفصلل الاول// زر عند الضغط عليه نظهر مواد الفصل االثاني
            ],
          ),
          subjectsProvider.subjectsForHomeScreen(userYear: usr.userYear ?? 1,userDep: usr.userDep ?? 1).isEmpty
              ? const LoadingCircle()
              : Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          subjectsProvider.subjectsForHomeScreen(userYear: usr.userYear ?? 1,userDep: usr.userDep ?? 1).length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1.3 / 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        final varSubject =
                            subjectsProvider.subjectsForHomeScreen(userYear: usr.userYear ?? 1,userDep: usr.userDep ?? 1)[index];

                        final varTitle = varSubject.name;
                        final varId = varSubject.id;
                        return SubjectItem(
                          varTitle ?? '',
                          '/FilesScreen',
                          varId ?? 0,
                          true,
                        ); // قائمة المواد الظاهرة
                      }),
                )
        ],
      ),
    );
  }
}
