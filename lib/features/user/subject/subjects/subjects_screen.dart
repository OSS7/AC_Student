import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/user/subject/subjects/providers/subjects_provider.dart';
import 'package:ac_students/features/user/subject/subjects/widgets/subject_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.decelerate));
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final subjectsProvider =
        Provider.of<SubjectsProvider>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context);
    final usr = Provider.of<UserProvider>(context);

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('SubjectsLabel'),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
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
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: size.width * 0.8,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                            color: subjectsProvider.selectedSubject == 3
                                ? secondaryClr
                                : secondaryClr.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              subjectsProvider.subjectChangeSem(3);
                            });
                          },
                          child: Text(
                            lan.get('DownLabel').toString(),
                            style: TextStyle(color: primaryClr),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SlideTransition(
                position: offset!,
                child: SizedBox(
                  width: size.width,
                  // height: size.height  * 0.8,
                  child: GridView.builder(
                    itemCount: subjectsProvider
                        .subjectsForSubjectsScreen(
                            userYear: usr.userYear ?? 1,
                            userDep: usr.userDep ?? 1)
                        .length,
                    itemBuilder: (context, index) {
                      final varSubject =
                          subjectsProvider.subjectsForSubjectsScreen(
                              userYear: usr.userYear ?? 1,
                              userDep: usr.userDep ?? 1)[index];

                      final varTitle = varSubject.name;
                      final varId = varSubject.id;
                      return Center(
                          child: SubjectItem(varTitle ?? '', '/FilesScreen',
                              varId ?? 0, false));
                    },
                    padding: edge10,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
