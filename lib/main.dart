import 'package:ac_students/admin/screens/reports_list_screen.dart';
import 'package:ac_students/student/screens/home_screen.dart';
import 'package:ac_students/student/screens/report_screen.dart';
import 'package:ac_students/home/screens/my_home_app.dart';
import 'package:ac_students/providers/reports.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ac_students/admin/providers/admin_provider.dart';
import 'package:ac_students/admin/screens/add_marks_screen.dart';
import 'package:ac_students/admin/screens/add_news_screen.dart';
import 'package:ac_students/admin/screens/add_photo_screen.dart';
import 'package:ac_students/admin/screens/add_file_screen.dart';
import 'package:ac_students/admin/screens/delete_screen.dart';
import 'package:ac_students/student/screens/about_screen.dart';
import 'package:ac_students/student/screens/chat_screen.dart';
import 'package:ac_students/student/screens/downloaded_screen.dart';
import 'package:ac_students/student/screens/files_screen.dart';
import 'package:ac_students/student/screens/gallery_screen.dart';
import 'package:ac_students/student/screens/marks_screen.dart';
import 'package:ac_students/student/screens/news_screen.dart';
import 'package:ac_students/student/screens/profile_screen.dart';
import 'package:ac_students/student/screens/image_screen.dart';
import 'package:ac_students/student/screens/setting_screen.dart';
import 'package:ac_students/providers/files.dart';
import 'package:ac_students/providers/images.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/messages.dart';
import 'package:ac_students/providers/news.dart';
import 'package:ac_students/providers/subjects.dart';
import 'package:ac_students/providers/user.dart';
import 'package:ac_students/home/screens/login_screen.dart';
import 'package:ac_students/home/screens/signup_screen.dart';
import 'package:ac_students/data/providers_data.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'student/screens/subjects_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'providers/marks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  const keyClientKey = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
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
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => Newses()),
        ChangeNotifierProvider(create: (context) => Files()),
        ChangeNotifierProvider(create: (context) => Subjects()),
        ChangeNotifierProvider(create: (context) => Messages()),
        ChangeNotifierProvider(create: (context) => Images()),
        ChangeNotifierProvider(create: (context) => Marks()),
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => Reports()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.elMessiriTextTheme(
            ),
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
            '/DownloadedScreen': (context) => const DownloadedScreen(),
            '/ReportsListScreen': (context) => const ReportsListScreen(),
            '/FilesScreen': (context) => const FilesScreen(),
          },
          home: const MyHomeApp(),
        );
      },
    );
  }
}
