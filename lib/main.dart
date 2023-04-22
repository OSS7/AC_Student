import 'package:ac_students/base_screen.dart';
import 'package:ac_students/core/utils/providers/admin_provider.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/providers/providers_data.dart';
import 'package:ac_students/features/about_us/about_screen.dart';
import 'package:ac_students/features/admin/delete/delete_screen.dart';
import 'package:ac_students/features/admin/file/add_file_screen.dart';
import 'package:ac_students/features/admin/images/add_photo_screen.dart';
import 'package:ac_students/features/admin/mark/add_marks_screen.dart';
import 'package:ac_students/features/admin/news/add_news_screen.dart';
import 'package:ac_students/features/admin/reports/reports_list_screen.dart';
import 'package:ac_students/features/auth/login/login_screen.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/auth/sign_up/signup_screen.dart';
import 'package:ac_students/features/home/home_screen.dart';
import 'package:ac_students/features/profile/profile_screen.dart';
import 'package:ac_students/features/setting/setting_screen.dart';
import 'package:ac_students/features/student/chat/chat_screen.dart';
import 'package:ac_students/features/student/chat/providers/chat_provider.dart';
import 'package:ac_students/features/student/file/files_screen.dart';
import 'package:ac_students/features/student/file/providers/files_provider.dart';
import 'package:ac_students/features/student/images/gallery/gallery_screen.dart';
import 'package:ac_students/features/student/images/image/image_screen.dart';
import 'package:ac_students/features/student/images/image/providers/images_provider.dart';
import 'package:ac_students/features/student/mark/marks_screen.dart';
import 'package:ac_students/features/student/news/news_screen.dart';
import 'package:ac_students/features/student/news/providers/news_provider.dart';
import 'package:ac_students/features/student/report/providers/reports_provider.dart';
import 'package:ac_students/features/student/report/report_screen.dart';
import 'package:ac_students/features/student/subject/failed_subject/failed_subject_screen.dart';
import 'package:ac_students/features/student/subject/subjects/providers/subjects_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'features/student/mark/providers/marks_provider.dart';
import 'features/student/subject/subjects/subjects_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = 'mx3Hp8DyzpdnNm5BLhEcpu2FMj9iW2IxlkzucYFq';
  const keyClientKey = 'd9wf7o89SxKJnu5vBOLQBrK6fCWBEDytK9PUOhEE';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey,
      liveQueryUrl: 'wss://graduate.b4a.io',
      debug: true);
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<ProvidersData>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProvidersData()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => NewsesProvider()),
        ChangeNotifierProvider(create: (context) => FilesProvider()),
        ChangeNotifierProvider(create: (context) => SubjectsProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => ImagesProvider()),
        ChangeNotifierProvider(create: (context) => MarksProvider()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => ReportsProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.elMessiriTextTheme(),
          ),
          initialRoute: '/',
          routes: {
            '/LoginScreen': (context) => const LoginScreen(),
            '/RegisterScreen': (context) => const RegisterScreen(),
            '/HomeScreen': (context) => const HomeScreen(),
            '/SubjectsScreen': (context) => const SubjectsScreen(),
            '/ChatScreen': (context) => const ChatScreen(),
            '/MarksScreen': (context) => const MarksScreen(),
            '/AboutScreen': (context) => const AboutScreen(),
            '/SettingScreen': (context) => const SettingScreen(),
            '/NewsScreen': (context) => const NewsScreen(),
            '/ProfileScreen': (context) => const ProfileScreen(),
            '/GalleryScreen': (context) => const GalleryScreen(),
            '/ReportScreen': (context) => const ReportScreen(),
            '/AddFileScreen': (context) => const AddFileScreen(),
            '/AddNewsScreen': (context) => const AddNewsScreen(),
            '/AddPhotoScreen': (context) => const AddPhotoScreen(),
            '/AddMarksScreen': (context) => const AddMarksScreen(),
            '/DeleteScreen': (context) => const DeleteScreen(),
            '/ImageScreen': (context) => const ImageScreen(),
            '/FailedSubjectScreen': (context) => const FailedSubjectScreen(),
            '/ReportsListScreen': (context) => const ReportsListScreen(),
            '/FilesScreen': (context) => const FilesScreen(),
          },
          home: const MyHomeApp(),
        );
      },
    );
  }
}
