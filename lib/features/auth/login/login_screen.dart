import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/auth_button.dart';
import 'package:ac_students/core/utils/widgets/custom_logo.dart';
import 'package:ac_students/core/utils/widgets/custom_text_fields.dart';
import 'package:ac_students/features/auth/login/widgets/login_fields.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: secondaryClr,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: primaryClr,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/SettingScreen', (Route<dynamic> route) => false,
                              arguments: true);
                        },
                      ),
                    ),
                    const CustomLogo(),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: primaryClr.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 25,
                            offset: const Offset(
                                0, -5), // changes position of shadow
                          ),
                        ],
                        color: primaryClr,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    width: size.width * 1,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const LoginFields(),
                          Container(
                            width: size.width,
                            // height: size.height * 0.08,
                            color: primaryClr,
                            child: Column(
                              children: [
                                Text(
                                  lan.get('YouDontHaveAccount').toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                  child: Text(
                                    lan.get('SignUp').toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: secondaryClr,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () async {
                                    Navigator.pushNamed(
                                        context, '/RegisterScreen');
                                  },
                                )
                              ],
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
