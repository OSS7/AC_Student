import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/core/widgets/custom_text_fields.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/admin_provider.dart';
import '../../../core/widgets/departments_row.dart';
import '../../../core/widgets/logo_container.dart';
import '../../../core/widgets/subjects_list.dart';
import 'widgets/add_file_button.dart';

class AddFileScreen extends StatefulWidget {
  const AddFileScreen({Key? key}) : super(key: key);

  @override
  State<AddFileScreen> createState() => _AddFileScreenState();
}

class _AddFileScreenState extends State<AddFileScreen> {
  final _name = TextEditingController();
  final _link = TextEditingController();

  int? selectedIndex1;
  int? selectedIndex2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final admin = Provider.of<AdminProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get(
            'AddFileLabel',
          ),
        ),
        drawer: const DrawerWidget(),
        body: Column(
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
                  // height: size.height * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextField(
                        control: _name,
                        hntText: 'File name',
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      CustomTextField(
                        control: _link,
                        hntText: 'File drive link',
                        maxLength: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.05,
                          child: ListView.builder(
                              itemCount: 2,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                return DepartmentRow(index: index);
                              }),
                        ),
                      ),
                      Container(
                        margin: edge20,
                        width: size.width,
                        height: size.height * 0.3,
                        child: const SubjectsList(),
                      ),
                      AddFileButton(
                          name: _name, subjectId: admin.subjectId, link: _link),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
