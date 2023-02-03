import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/loading_circle.dart';
import 'package:ac_students/features/user/file/providers/files_provider.dart';
import 'package:ac_students/features/user/file/widgets/file_item.dart';
import 'package:ac_students/features/user/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFilesWidget extends StatelessWidget {
  const HomeFilesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final filesProvider = Provider.of<FilesProvider>(context);
    final subjectProvider = Provider.of<SubjectsProvider>(context);

    return Visibility(
      visible: filesProvider.specificFiles.isNotEmpty,
      child: filesProvider.files.isEmpty
          ? const LoadingCircle()
          : Container(
              padding: edge10,
              width: size.width * 1,
              height: size.height * 0.2,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filesProvider.specificFiles.length,
                  itemBuilder: (context, index) {
                    final varFile = filesProvider.specificFiles[index];
                    final varSubject = subjectProvider.subjects
                        .firstWhere(
                            (element) => element.id == varFile.subjectId)
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
    );
  }
}
