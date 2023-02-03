import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/features/auth/login/login_screen.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryClr,
      body: FutureBuilder<bool>(
          future: userProvider.hasUserLogged(),
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: RefreshProgressIndicator(
                      color: secondaryClr,
                    ),
                  ),
                );
              default:
                // return LoginScreen();
                if (snapshot.data == true) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
            }
          }),
    );
  }
}
