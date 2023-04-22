import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/student/file/model/file.dart';
import 'package:ac_students/features/student/file/providers/files_provider.dart';
import 'package:ac_students/features/student/file/widgets/file_item.dart';
import 'package:ac_students/features/student/subject/subjects/model/subject.dart';
import 'package:ac_students/features/student/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/constant.dart';

class FilesScreen extends StatefulWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  _FilesScreenState createState() => _FilesScreenState();
}

class _FilesScreenState extends State<FilesScreen> {
  @override
  Widget build(BuildContext context) {
    final filesProvider = Provider.of<FilesProvider>(context, listen: false);
    final subjectsProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    int? subjectId = argument['id'];
    bool? isFromHome = argument['isFromHome'];
    final lan = Provider.of<LanguageProvider>(context);
    final size = MediaQuery.of(context).size;

    List<File>? specFiles = filesProvider.files
        .where((element) => element.subjectId == subjectId)
        .toList();

    Subject? thisSubject = subjectsProvider.subjects
        .firstWhere((element) => element.id == subjectId);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: '${lan.get('FilesLabel')} ${thisSubject.name}',
          child: IconButton(
            onPressed: () {
              isFromHome ?? false
                  ? Navigator.pushNamed(context, '/HomeScreen',
                      arguments: thisSubject.season ?? 1)
                  : Navigator.pushNamed(context, '/SubjectsScreen',
                      arguments: thisSubject.season ?? 1);
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: primaryClr,
            ),
          ),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: Container(
          padding: edge10,
          width: size.width,
          height: size.height * 0.9,
          child: specFiles.isNotEmpty
              ? ListView.builder(
                  itemCount: specFiles.length,
                  itemBuilder: (context, index) {
                    final varFile = specFiles[index];
                    final varLink = varFile.link;
                    final varName = varFile.name;
                    final varSubject = subjectsProvider.subjects
                        .firstWhere(
                            (element) => element.id == varFile.subjectId)
                        .name;
                    return FileItem(
                      varName: varName,
                      varLink: varLink,
                      subject: varSubject,
                    );
                  },
                )
              : Center(
                  child: Text(
                  lan.get('FilesEmpty').toString(),
                  style: TextStyle(fontSize: 30, color: secondaryClr),
                )),
        ),
      ),
    );
  }
}
