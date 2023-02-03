import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/core/widgets/custom_text_fields.dart';
import 'package:ac_students/core/widgets/logo_container.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/user/report/providers/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _report = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final reportProvider = Provider.of<ReportsProvider>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context, listen: false);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryClr,
        appBar: AppBarWidget(
          txt: lan.get('ReportLabel'),
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
                      padding: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        color: primaryClr,
                      ),
                      width: size.width * 1,
                      height: size.height * 0.70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              CustomTextField(
                                control: _report,
                                hntText: lan.get('ReportText'),
                                maxLength: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  lan.get('NameReport').toString(),
                                  style: TextStyle(color: secondaryClr),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              reportProvider.addReport(context, _report.text);
                              setState(() {
                                _report.clear();
                              });
                            },
                            child: Container(
                              width: 140,
                              height: 50,
                              decoration: BoxDecoration(
                                color: secondaryClr,
                                borderRadius: radius25All,
                              ),
                              child: Center(
                                child: Text(
                                  lan.get('AddReport').toString(),
                                  style: TextStyle(
                                    color: primaryClr,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
