import 'package:flutter/material.dart';

import '../../../../core/utils/widgets/departments_row.dart';

class AddFileDepartmentRow extends StatelessWidget {
  const AddFileDepartmentRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        width: size.width * 0.9,
        height: size.height * 0.05,
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return DepartmentRow(index: index);
          },
        ),
      ),
    );
  }
}
