import 'dart:io';

import 'package:ac_students/admin/widgets/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ac_students/admin/widgets/logo_container.dart';

import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';

import 'package:ac_students/home/widgets/register_input.dart';

import 'package:provider/provider.dart';
import 'package:ac_students/providers/images.dart';
import 'package:ac_students/providers/language_provider.dart';

import 'package:ac_students/providers/news.dart';

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({Key? key}) : super(key: key);

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final _title = TextEditingController();
  XFile? imageFile;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageProvider = Provider.of<Images>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context, listen: false);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: primaryClr,
        appBar: AppBarWidget(
          txt: lan.get('AddPhotoLabel'),
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
                      padding: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        color: primaryClr,
                      ),
                      width: size.width * 1,
                      // height: size.height * 0.70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RegisterInput(
                            control: _title,
                            hntText: 'Photo title',
                            maxLength: 2,
                          ),
                          imageFile != null
                              ? SizedBox(
                                  width: size.width * 0.6,
                                  height: size.height * 0.3,
                                  child: Image.file(File(imageFile!.path)))
                              : const SizedBox(),
                          TextButton(
                            onPressed: () async {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 1800,
                                maxHeight: 1800,
                              );
                              setState(() {
                                if (pickedFile != null) {
                                  imageFile = pickedFile;
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),

                              width: 140,
                              height: 50,
                              decoration: BoxDecoration(
                                color: secondaryClr,
                                borderRadius: radius25All,
                              ),
                              child: Center(
                                child: Text(
                                  'Pick photo',
                                  style: TextStyle(
                                    color: primaryClr,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              imageProvider.addImage(
                                  context, _title.text, File(imageFile!.path));
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
                                  lan.get('AddPhotoLabel').toString(),
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
