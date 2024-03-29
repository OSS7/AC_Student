import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/auth/sign_up/widgets/year_txt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/admin_provider.dart';

class DepartmentRow extends StatefulWidget {
  final int index;

  const DepartmentRow({Key? key, required this.index}) : super(key: key);

  @override
  State<DepartmentRow> createState() => _DepartmentRowState();
}

class _DepartmentRowState extends State<DepartmentRow> {
  @override
  Widget build(BuildContext context) {
    final admin = Provider.of<AdminProvider>(context);
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(
          () {
            admin.changeDepartment();
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: admin.selectedDep == widget.index + 1
              ? secondaryClr
              : secondaryClr.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Center(
          child: widget.index == 0
              ? const Txt('Computer Technology')
              : widget.index == 1
                  ? const Txt('Mechatronics')
                  : const Text('null'),
        ),
      ),
    );
  }
}
