import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('AboutLabel'),
        ),
        backgroundColor: primaryClr,
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              lan.get('AppDescribe').toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23, color: secondaryClr),
            ),
          ),
        ),
      ),
    );
  }
}
