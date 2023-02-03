import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/auth/sign_up/widgets/year_txt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearWidget extends StatefulWidget {
  int? selectedIndex;

  YearWidget({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<YearWidget> createState() => _YearWidgetState();
}

class _YearWidgetState extends State<YearWidget> {
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
                lan.get('WhichYear').toString(),
                style: TextStyle(fontSize: 20, color: secondaryClr),
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.01,
            // ),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.06,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          userProvider.selectedYear = index + 1;
                          widget.selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: edge5,
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                            color: widget.selectedIndex == index
                                ? secondaryClr
                                : secondaryClr.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: index == 0
                              ? Txt(lan.get('1st'))
                              : index == 1
                                  ? Txt(lan.get('2nd'))
                                  : index == 2
                                      ? Txt(lan.get('3rd'))
                                      : index == 3
                                          ? Txt(lan.get('4th'))
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
