import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/providers/language_provider.dart';
import '../../../../core/utils/widgets/auth_button.dart';
import '../../../../core/utils/widgets/custom_text_fields.dart';
import '../../providers/user_provider.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({Key? key}) : super(key: key);

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.08,
        ),
        CustomTextField(
          control: emailController,
          hntText: lan.get('Email'),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        CustomTextField(
          control: passwordController,
          hntText: lan.get('Password'),
          type: inputType.password,
        ),
        SizedBox(
          height: size.height * 0.04,
        ),
        AuthButton(
            onPress: () {
              user.doUserLogin(
                  // usernameController,
                  emailController,
                  passwordController,
                  user.selectedIndex ?? 1,
                  context);
            },
            label: lan.get('Login').toString()),
        SizedBox(
          height: size.height * 0.02,
        ),
      ],
    );
  }
}
