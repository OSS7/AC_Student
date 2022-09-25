import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/student/widgets/app_bar.dart';
import 'package:ac_students/student/widgets/drawer.dart';
import 'package:ac_students/student/widgets/logout_button.dart';
import 'package:provider/provider.dart';
import 'package:ac_students/providers/language_provider.dart';
import 'package:ac_students/providers/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  Animation<Offset>? offset;
  Animation? animation;


  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offset = Tween<Offset>(begin: const Offset(1.0,0.0),  end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController!, curve: Curves.decelerate));
    _animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<User>(context, listen: true);
    final lan = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBarWidget(
          txt: lan.get('ProfileLabel'),
        ),
        drawer: const DrawerWidget(),
        backgroundColor: primaryClr,
        body: SlideTransition(
          position: offset!,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: edge10,
                  child: Column(
                    // overflow: Overflow.clip,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: size.width * 0.5,
                          height: size.height * 0.2,
                          child: CircleAvatar(
                            backgroundColor: primaryClr,
                            child: Image.asset(
                                'images/avatars/${userProvider.userImage}.png'),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(bottom: size.height * 0.08),
                          child: Text("${userProvider.userName.toString()} ",
                              style:
                                    TextStyle(
                                      color: secondaryClr,
                                      fontSize: 30
                                    ),
                          )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.email,
                            color: secondaryClr,
                          ),
                          SizedBox(
                            width: size.width * 0.05,
                          ),
                          Expanded(
                            child: Text('${userProvider.userEmail}',
                                style: TextStyle(fontSize: 18, color: secondaryClr)
                                ),
                          ),
                          Icon(
                            userProvider.verfied  ?  Icons.verified_user_sharp : Icons.verified_user_outlined,
                            color: secondaryClr,

                          ),
                        ],
                      ),
                      Divider(
                        color: secondaryClr,
                        height: 50,
                      ),
                      SizedBox(
                        height: size.height * 0.06,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Text(
                                '${lan.get('FromYear')} \n ${userProvider.userYear}',
                                style: TextStyle(fontSize: 15, color: secondaryClr),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: size.height * 0.06,
                              color: secondaryClr,
                              width: 2,
                            ),
                            FittedBox(
                              child: Text(
                                '${lan.get('At')} \n ${userProvider.userDep == 1 ? '${lan.get('CompDep')}' : '${lan.get('MechDep')}'} ',
                                style: TextStyle(fontSize: 15, color: secondaryClr),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: secondaryClr,
                        height: 50,
                      ),
                      ListTile(
                        onTap: (){
                          Navigator.pushNamed(context, '/DownloadedScreen');
                        },
                          leading: Icon(
                            Icons.download_sharp,
                            color: secondaryClr,
                          ),
                          title: Text(
                            lan.get('DownLabel').toString(),
                              style:
                                  TextStyle(fontSize: 20, color: secondaryClr),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const LogoutButton()
            ],
          ),
        ),
      ),
    );
  }
}
