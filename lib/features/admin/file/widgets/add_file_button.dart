import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/student/file/providers/files_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFileButton extends StatefulWidget {
  final TextEditingController name;
  final int subjectId;
  final TextEditingController link;

  const AddFileButton(
      {Key? key,
      required this.name,
      required this.subjectId,
      required this.link})
      : super(key: key);

  @override
  State<AddFileButton> createState() => _AddFileButtonState();
}

class _AddFileButtonState extends State<AddFileButton> {
  @override
  Widget build(BuildContext context) {
    final filesProvider = Provider.of<FilesProvider>(context);

    return TextButton(
      onPressed: () {
        filesProvider.addFile(
          context,
          widget.name.text.toString(),
          widget.subjectId,
          widget.link.text.toString(),
        );
        setState(() {
          widget.name.clear();
          widget.link.clear();
        });
      },
      child: Container(
        width: 140,
        height: 50,
        decoration: BoxDecoration(
          color: secondaryClr,
          borderRadius: radius25All,
        ),
        child: Center(
          child: Text(
            'Add file',
            style: TextStyle(
              color: primaryClr,
            ),
          ),
        ),
      ),
    );
  }
}
