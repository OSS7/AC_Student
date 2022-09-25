import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/user.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [errorClr.withOpacity(0.6), errorClr],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      width: double.infinity,
      // padding: edge10,
      // height: 40,
      child: ListTile(
        title: Text(
          lan.get('Logout').toString(),
          textAlign: TextAlign.left,
          style: TextStyle(
              color: primaryClr, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        leading: Icon(
          Icons.logout,
          color: primaryClr,
        ),
        // tileColor: Colors.blue,
        onTap: () {
          userProvider.doUserLogout(context);
        },
      ),
    );
  }
}
