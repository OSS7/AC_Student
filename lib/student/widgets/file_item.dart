import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/data/providers_data.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/providers/files.dart';

class FileItem extends StatelessWidget {
  final String? varName;
  final String? subject;
  final String? varLink;
  const FileItem({Key? key, this.varName, this.varLink, this.subject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filesProvider = Provider.of<Files>(context);
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
