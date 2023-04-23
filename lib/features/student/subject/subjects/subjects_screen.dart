import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/student/subject/subjects/providers/subjects_provider.dart';
import 'package:ac_students/features/student/subject/subjects/widgets/subject_item.dart';
import 'package:ac_students/features/student/subject/subjects/widgets/subjects_semesters_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/subjects_subjects_listview.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subjectsProvider = Provider.of<SubjectsProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('SubjectsLabel'),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SubjectSemestersRow(),
                SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size.width * 0.8,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            color: subjectsProvider.selectedSubject == 3
                                ? secondaryClr
                                : secondaryClr.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              subjectsProvider.subjectChangeSem(3);
                            });
                          },
                          child: Text(
                            lan.get('DownLabel').toString(),
                            style: TextStyle(color: primaryClr),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SubjectsSubjectsListView(),
          ],
        ),
      ),
    );
  }
}
