import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/app_bar.dart';
import 'package:ac_students/core/utils/widgets/custom_text_fields.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/student/news/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/widgets/logo_container.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final _news = TextEditingController();

  int? selectedIndex1;
  int? selectedIndex2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final newsProvider = Provider.of<NewsesProvider>(context);
    final lan = Provider.of<LanguageProvider>(context, listen: false);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryClr,
        appBar: AppBarWidget(
          txt: lan.get('AddNewsLabel'),
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
                          CustomTextField(
                            control: _news,
                            hntText: 'News text',
                            maxLength: 3,
                          ),
                          TextButton(
                            onPressed: () {
                              newsProvider.addNews(context, _news.text);
                              setState(() {
                                _news.clear();
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
                                  lan.get('AddNewsLabel').toString(),
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
