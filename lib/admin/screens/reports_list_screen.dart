import 'package:ac_students/admin/widgets/logo_container.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/reports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lan = Provider.of<LanguageProvider>(context);
    final size = MediaQuery.of(context).size;
    final _reports = Provider.of<Reports>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryClr,
        appBar: AppBarWidget(
          txt: lan.get('ReportListLabel'),
        ),
        drawer: const DrawerWidget(),
        body: Column(
          children: [
            const LogoContainer(),
            Expanded(
              child: ListView.builder(
                  itemCount: _reports.reports.length,
                  itemBuilder: (context, index) {
                    final varReport = _reports.reports[index];
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: secondaryClr,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                Text(
                                  '.',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: secondaryClr,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                                Expanded(
                                  child: Text(
                                    ' ${varReport.title.toString()} ',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: secondaryClr,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: secondaryClr,
                          ),
                        ],
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
