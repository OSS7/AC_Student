import 'package:ac_students/core/constant/constant.dart';
import 'package:ac_students/core/providers/language_provider.dart';
import 'package:ac_students/core/widgets/app_bar.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/drawer.dart';
import 'package:ac_students/features/home/widgets/home_files_widget.dart';
import 'package:ac_students/features/home/widgets/home_header.dart';
import 'package:ac_students/features/home/widgets/home_news_widget.dart';
import 'package:ac_students/features/home/widgets/home_subjects_widget.dart';
import 'package:ac_students/features/user/file/providers/files_provider.dart';
import 'package:ac_students/features/user/images/image/providers/images_provider.dart';
import 'package:ac_students/features/user/mark/providers/marks_provider.dart';
import 'package:ac_students/features/user/news/providers/news_provider.dart';
import 'package:ac_students/features/user/report/providers/reports_provider.dart';
import 'package:ac_students/features/user/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.bounceOut));
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final subjectsProvider =
        Provider.of<SubjectsProvider>(context, listen: false);
    final newsProvider = Provider.of<NewsesProvider>(context, listen: false);
    final filesProvider = Provider.of<FilesProvider>(context, listen: false);
    final marksProvider = Provider.of<MarksProvider>(context, listen: false);
    final lan = Provider.of<LanguageProvider>(context, listen: false);
    final imagesProvider = Provider.of<ImagesProvider>(context, listen: true);
    final reportProvider = Provider.of<ReportsProvider>(context, listen: true);
    final usr = Provider.of<UserProvider>(context, listen: false);

    return SafeArea(
      child: Directionality(
        textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
        // اذا كانت اللغة عربية اجعل محتوى الصفحة من اليمين الى اليسار والا اجعله من اليسار الى اليمين
        child: Scaffold(
          appBar: AppBarWidget(
            txt: lan.get('HomeLabel'), // الجزء العلوي من الصفحة
          ),
          drawer: const DrawerWidget(), // زر النافذة الجانبية
          backgroundColor: primaryClr, // لون الخلفية باللون الاساسي
          body: FutureBuilder(
              future: Future.wait([
                subjectsProvider.getSubjects(),
                filesProvider.getFiles(
                    userDep: usr.userDep ?? 1, userYear: usr.userYear ?? 1),
                newsProvider.getNews(),
                reportProvider.getReports(),
                marksProvider.getMarks(userDep: usr.userDep ?? 1),
                imagesProvider.getImages(),
                lan.getIsAr(),
                usr.getVariables(),
              ]),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HomeHeader(),
                    // الجزء العلوي من الصفحة الموجود فيه رسالة الترحيب واسم الطالب والصورة العلوية
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryClr,
                          ),
                          child: SlideTransition(
                            // الحركات التي تحصل اول فتح الصفحة
                            position: offset!,
                            child: Column(
                              children: const [
                                HomeSubjectsWidget(),
                                // القسم الخاص بالمواد التي تظهر في الصفحة الرئيسية
                                HomeFilesWidget(),
                                // القسم الخاص بالملفات الاخيرة التي تظهر في الصفحة الرئيسية
                                HomeNewsWidget(),
                                // القسم الخاص بالاخبار التي تظهر في الصفحة الرئيسية
                                //  لاختصار الشيفرة ولسهولة فهمها  ولسهولة التعديل عليها  فيما بعد  قمنا باستخراج كل قسم الى ملف  لوحدة
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
