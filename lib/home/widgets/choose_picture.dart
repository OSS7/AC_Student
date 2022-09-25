import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/user.dart';

class ChoosePicture extends StatelessWidget {
  const ChoosePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<User>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return AlertDialog(
        title: Text(
          lan.get('ChoosingPicture').toString(),
        ),
        content: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.3,
          child: GridView.builder(
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 1.5 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  userProvider.changProfilePicture(index + 1);
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: size.width * 0.05,
                  height: size.height * 0.05,
                  child: CircleAvatar(
                      child: Image.asset('images/avatars/${index + 1}.png')),
                ),
              );
            },
          ),
        ));
  }
}
