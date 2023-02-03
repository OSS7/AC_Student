import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/auth/sign_up/widgets/year_txt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constant/constant.dart';

class DepartmentWidget extends StatefulWidget {
  int? selectedDepartment;

  DepartmentWidget({Key? key, this.selectedDepartment}) : super(key: key);

  @override
  State<DepartmentWidget> createState() => _DepartmentWidgetState();
}

class _DepartmentWidgetState extends State<DepartmentWidget> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.9,
              // height: size.height * 0.70,
              child: Text(
                lan.get('WhichDepartment').toString(),
                // textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: secondaryClr),
              ),
            ),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.06,
              child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userProvider.selectedDepartment = index + 1;
                          widget.selectedDepartment = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        padding: edge5,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                            color: widget.selectedDepartment == index
                                ? secondaryClr
                                : secondaryClr.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: index == 0
                              ? Txt(lan.get('CompDep'))
                              : index == 1
                                  ? Txt(lan.get('MechDep'))
                                  : const Text('null'),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
