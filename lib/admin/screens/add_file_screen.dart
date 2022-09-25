import 'package:ac_students/admin/widgets/add_file_button.dart';
import 'package:ac_students/admin/widgets/departments_row.dart';
import 'package:ac_students/admin/widgets/subjects_list.dart';
import 'package:flutter/material.dart';
import 'package:ac_students/admin/providers/admin_provider.dart';
import 'package:ac_students/admin/widgets/logo_container.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/models/subject.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:ac_students/home/widgets/register_input.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/home/widgets/year_txt.dart';
import 'package:ac_students/providers/files.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/subjects.dart';
import 'package:ac_students/providers/user.dart';

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
                      RegisterInput(
                        control: _name,
                        hntText: 'File name',
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      RegisterInput(
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
                      AddFileButton(name: _name, subjectId: admin.subjectId, link: _link),
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
