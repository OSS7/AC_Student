import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/core/widgets/custom_text_fields.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/departments_row.dart';
import '../../../core/widgets/logo_container.dart';
import '../../../core/widgets/subjects_list.dart';
import 'widgets/add_marks.dart';

class AddMarksScreen extends StatefulWidget {
  const AddMarksScreen({Key? key}) : super(key: key);

  @override
  State<AddMarksScreen> createState() => _AddMarksScreenState();
}

class _AddMarksScreenState extends State<AddMarksScreen> {
  final _link = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(
      context,
    );

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryClr,
        appBar: AppBarWidget(
          txt: lan.get(
            'AddMarksLabel',
          ),
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: SizedBox(
            height: size.height * 1,
            width: size.width * 1,
            child: Column(
              // alignment: Alignment.center,
              children: [
                const LogoContainer(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 40,
                      ),
                      decoration: BoxDecoration(
                        color: primaryClr,
                      ),
                      width: size.width * 1,
                      height: size.height * 0.70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextField(
                            control: _link,
                            hntText: 'File drive link',
                            maxLength: 3,
                          ),
                          SizedBox(
                            width: size.width * 0.9,
                            height: size.height * 0.05,
                            child: ListView.builder(
                                itemCount: 2,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (
                                  ctx,
                                  index,
                                ) {
                                  return DepartmentRow(
                                    index: index,
                                  );
                                }),
                          ),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.3,
                            child: const SubjectsList(),
                          ),
                          AddMarksButton(link: _link),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
