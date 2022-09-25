import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/data/providers_data.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:ac_students/student/widgets/setting_switch_tile.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/user.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Offset>? offset;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.decelerate));
    _animationController?.forward();
  }

  List<int> colorsDark = [
    0xffFFFFFF,
    0xffbdbdbd,
    0xff42a5f5,
    0xff4dd0e1,
    0xff43a047,
    0xfffff176,
    0xffFF5722,
    0xffc62828,
  ];
  List<int> colorsLight = [
    0xff000000,
    0xff263238,
    0xff6a1b9a,
    0xff1a237e,
    0xff006064,
    0xff1b5e20,
    0xfff57f17,
    0xffb71c1c,
  ];
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final provider = Provider.of<ProvidersData>(context, listen: true);
    final userProvider = Provider.of<User>(context, listen: true);
    bool? arg = (ModalRoute.of(context)!.settings.arguments ?? false) as bool?;
    List<int> colors = box.read('mode') ?? false ? colorsDark : colorsLight;

    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('SettingLabel'),
          child: (arg ?? false)
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/LoginScreen', (Route<dynamic> route) => false);
                  },
                )
              : null,
        ),
        drawer: !(arg ?? false) ? const DrawerWidget() : null,
        backgroundColor: primaryClr,
        body: SlideTransition(
          position: offset!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SettingSwitchTile(
                  title: lan.get('DarkMode')!,
                  description: lan.get('EnDarkMode')!,
                  currentValue: box.read('mode') ?? false,
                  updateState: (newValue) {
                    setState(() {
                      provider.changPriColor();
                    });
                  }),
              SettingSwitchTile(
                  title: lan.get('ArabicLang')!,
                  description: lan.get('EnArabicLang')!,
                  // currentValue: box.read('language') ?? false,
                  currentValue: lan.isAr,
                  updateState: (newValue) {
                    setState(() {
                      lan.changLanguage();
                    });
                  }),
              !(arg ?? false)
                  ? userProvider.isAdmin ?? false
                      ? SettingSwitchTile(
                          title: lan.get('enChat')!,
                          description: lan.get('enChatSub')!,
                          // currentValue: box.read('language') ?? false,
                          currentValue: userProvider.enableChat ?? false,
                          updateState: (newValue) {
                            setState(() {
                              userProvider
                                  .updateChatEnable(userProvider.variabel!.id);
                            });
                          })
                      : const SizedBox()
                  : const SizedBox(),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        lan.get('PrimaryColor')!,
                        style: TextStyle(color: secondaryClr),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: colors.length,
                        itemBuilder: (context, i) {
                          return SizedBox(
                            // height: size.height * 0.05,
                            width: size.width * 0.12,
                            child: MaterialButton(
                              // color: selected == i ? Colors.black45 : Colors.white,
                              onPressed: () {
                                setState(() {
                                  provider.changSecColor(colors[i]);
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Color(colors[i]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
