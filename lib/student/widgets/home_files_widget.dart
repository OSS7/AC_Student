import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/file_item.dart';
import 'package:ac_students/student/widgets/loading_circle.dart';
import 'package:ac_students/providers/files.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/subjects.dart';
import 'package:ac_students/providers/user.dart';

class HomeFilesWidget extends StatelessWidget {
  const HomeFilesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final filesProvider = Provider.of<Files>(context);
    final subjectProvider = Provider.of<Subjects>(context);

    return filesProvider.files.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 40),
                  width: size.width * 1,
                  child: Row(
                    children: [
                      Text(
                        lan.get('AddedLatest').toString(),
                        style: TextStyle(fontSize: 18, color: secondaryClr),
                      ),
                      Expanded(
                          child: Divider(
                        color: secondaryClr,
                      ))
                    ],
                  )),
              filesProvider.files.isEmpty
                  ? const LoadingCircle()
                  : Container(
                      padding: edge10,
                      width: size.width * 1,
                      height: size.height * 0.2,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: filesProvider.specificFiles.length >= 3
                              ? 3
                              : filesProvider.specificFiles.length == 2
                                  ? 2
                                  : 1,
                          itemBuilder: (context, index) {
                            final varFile = filesProvider.specificFiles[index];
                            final varSubject = subjectProvider.subjects
                                .firstWhere((element) =>
                                    element.id == varFile.subjectId)
                                .name;
                            final varLink = varFile.link;
                            final varName = varFile.name;
                            return FileItem(
                              varName: varName,
                              subject: varSubject,
                              varLink: varLink,
                            );
                          }),
                    ),
            ],
          );
  }
}
