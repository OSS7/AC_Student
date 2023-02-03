import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/user/subject/subjects/model/subject.dart';
import 'package:ac_students/features/user/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FailedSubjectScreen extends StatefulWidget {
  const FailedSubjectScreen({Key? key}) : super(key: key);

  @override
  State<FailedSubjectScreen> createState() => _FailedSubjectScreenState();
}

class _FailedSubjectScreenState extends State<FailedSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    final subjectsProvider =
        Provider.of<SubjectsProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final usr = Provider.of<UserProvider>(context);

    List<Subject> specSubjects = subjectsProvider.subjects
        .where((element) => element.department == usr.userDep)
        .toList();

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('DownLabel'),
          child: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pushNamed('/ProfileScreen');
            },
          ),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Container(
                padding: edge10,
                width: size.width,
                height: size.height * 0.9,
                child: ListView.builder(
                    itemCount: specSubjects.length,
                    itemBuilder: (context, index) {
                      Subject varSubjects = specSubjects[index];
                      final varName = varSubjects.name;
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              varName ?? '',
                              style:
                                  TextStyle(fontSize: 30, color: secondaryClr),
                            ),
                            leading: Icon(
                              subjectsProvider
                                      .isDownloadedSubject(varSubjects.id)
                                  ? Icons.download
                                  : Icons.download_outlined,
                              color: secondaryClr,
                            ),
                            onTap: () {
                              subjectsProvider
                                  .downloadedSubjectAddRemove(varSubjects);
                            },
                          ),
                          Divider(
                            color: secondaryClr,
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
