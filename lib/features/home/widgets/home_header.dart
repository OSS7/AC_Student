import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context);

    return Container(
      decoration: BoxDecoration(
          color: secondaryClr,
          gradient: LinearGradient(
              colors: [secondaryClr.withOpacity(0.2), secondaryClr],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      padding: edge5,
      width: size.width * 1,
      height: size.height * 0.15,
      //أخذ 15% من طول الشاشة
      child: Stack(
        children: [
          Align(
            alignment: lan.isAr ? Alignment.topRight : Alignment.topLeft,
            child: SizedBox(
              width: size.width * 0.4,
              height: size.height * 0.08,
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${lan.get('Greeting')} ${userProvider.userName} 😃',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: primaryClr),
                    ),
                    Text(
                      lan.get('Welcoming').toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 26,
                        color: primaryClr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: lan.isAr ? Alignment.bottomLeft : Alignment.bottomRight,
            child: SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.1,
              child: FittedBox(
                child: Image.asset(
                  'images/study.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
