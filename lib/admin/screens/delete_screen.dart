import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/admin/widgets/files_delete_widget.dart';
import 'package:ac_students/admin/widgets/images_delete_widget.dart';
import 'package:ac_students/admin/widgets/logo_container.dart';
import 'package:ac_students/admin/widgets/marks_delete_widget.dart';
import 'package:ac_students/admin/widgets/news_delete_widget.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:ac_students/providers/files.dart';
import 'package:ac_students/providers/language_provider.dart';
class DeleteScreen extends StatefulWidget {
  const DeleteScreen({Key? key}) : super(key: key);

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context, listen: true);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: 'Delete',
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const[
              LogoContainer(),
              FilesDeleteWidget(),
              MarksDeleteWidget(),
              NewsDeleteWidget(),
              PhotoDeleteWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
