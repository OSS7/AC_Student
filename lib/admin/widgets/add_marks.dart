import 'package:ac_students/admin/providers/admin_provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/providers/marks.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMarksButton extends StatefulWidget {
  final TextEditingController link;
  const AddMarksButton({Key? key, required this.link}) : super(key: key);

  @override
  State<AddMarksButton> createState() => _AddMarksButtonState();
}

class _AddMarksButtonState extends State<AddMarksButton> {
  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<AdminProvider>(context);
    final marksProvider = Provider.of<Marks>(context);

    return TextButton(
      onPressed: () {
        marksProvider.addMarks(
            context, admin.subjectId, widget.link.text);
        setState(() {
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
            'Add marks file',
            style: TextStyle(
              color: primaryClr,
            ),
          ),
        ),
      ),
    );
  }
}
