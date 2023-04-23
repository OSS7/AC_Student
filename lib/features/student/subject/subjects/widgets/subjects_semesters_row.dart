import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constant/constant.dart';
import '../../../../../core/utils/providers/language_provider.dart';
import '../providers/subjects_provider.dart';

class SubjectSemestersRow extends StatefulWidget {
  const SubjectSemestersRow({Key? key}) : super(key: key);

  @override
  State<SubjectSemestersRow> createState() => _SubjectSemestersRowState();
}

class _SubjectSemestersRowState extends State<SubjectSemestersRow> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subjectsProvider = Provider.of<SubjectsProvider>(context);
    final lan = Provider.of<LanguageProvider>(context);

    return Container(
      width: size.width * 0.9,
      height: size.height * 0.05,
      margin: edge10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: size.width * 0.4,
            height: size.height * 0.05,
            decoration: BoxDecoration(
                color: subjectsProvider.selectedSubject == 1
                    ? secondaryClr
                    : secondaryClr.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  subjectsProvider.subjectChangeSem(1);
                });
              },
              child: Text(
                lan.get('Semester1').toString(),
                style: TextStyle(color: primaryClr),
              ),
            ),
          ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.05,
            decoration: BoxDecoration(
                color: subjectsProvider.selectedSubject == 2
                    ? secondaryClr
                    : secondaryClr.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(15))),
            child: MaterialButton(
                onPressed: () {
                  setState(() {
                    subjectsProvider.subjectChangeSem(2);
                  });
                },
                child: Text(
                  lan.get('Semester2').toString(),
                  style: TextStyle(color: primaryClr),
                )),
          ),
        ],
      ),
    );
  }
}
