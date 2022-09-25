import 'package:ac_students/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/models/subject.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/subjects.dart';

class DownloadedScreen extends StatefulWidget {
  const DownloadedScreen({Key? key}) : super(key: key);

  @override
  State<DownloadedScreen> createState() => _DownloadedScreenState();
}

class _DownloadedScreenState extends State<DownloadedScreen> {

  @override
  Widget build(BuildContext context) {
    final subjectsProvider = Provider.of<Subjects>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final usr = Provider.of<User>(context);

    List<Subject> specSubjects = subjectsProvider.subjects
        .where((element) => element.department == usr.userDep)
        .toList();

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('DownLabel'),
          child: IconButton(
            icon:  Icon(Icons.arrow_back_outlined),
            onPressed: (){
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
                              style:  TextStyle(fontSize: 30, color: secondaryClr),
                            ),
                            leading: Icon(
                              subjectsProvider.isDownloadedSubject(varSubjects.id)
                                  ? Icons.download
                                  : Icons.download_outlined,
                              color: secondaryClr,
                            ),
                            onTap: (){
                                subjectsProvider.downloadedSubjectAddRemove(varSubjects);
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
