import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/logo_container.dart';
import 'widgets/files_delete_widget.dart';
import 'widgets/images_delete_widget.dart';
import 'widgets/marks_delete_widget.dart';
import 'widgets/news_delete_widget.dart';

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
            children: const [
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
