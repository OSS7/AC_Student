import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/student/file/providers/files_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FileItem extends StatelessWidget {
  final String? varName;
  final String? subject;
  final String? varLink;

  const FileItem({Key? key, this.varName, this.varLink, this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filesProvider = Provider.of<FilesProvider>(context);
    return Column(
      children: [
        ListTile(
          subtitle: Text(
            subject.toString(),
            style: TextStyle(color: secondaryClr),
          ),
          trailing: Icon(
            Icons.download,
            color: secondaryClr,
          ),
          title: Text(varName ?? '',
              style: TextStyle(fontSize: 18, color: secondaryClr)),
          onTap: () {
            filesProvider.downloadFile(context, varName ?? '', varLink ?? '');
          },
        ),
        Divider(
          color: secondaryClr,
        ),
      ],
    );
  }
}
