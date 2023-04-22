import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);

    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: edge10,
        width: size.width,
        height: size.height * 0.18,
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lan.get('AC').toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: primaryClr,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      lan.get('StudentApp').toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: primaryClr,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'images/logo1.png',
                color: primaryClr,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
