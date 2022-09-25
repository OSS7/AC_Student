import 'package:ac_students/student/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/providers/user.dart';
import 'package:ac_students/home/screens/login_screen.dart';
import 'package:provider/provider.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  State<MyHomeApp> createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<User>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryClr,
      body: FutureBuilder<bool>(
          future: userProvider.hasUserLogged(),
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: RefreshProgressIndicator(
                      color: secondaryClr,
                    ),
                  ),
                );
              default:
                // return LoginScreen();
                if (snapshot.data == true) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
            }
          }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:login_screen/data/constant.dart';
// import 'package:login_screen/student/widgets/drawer.dart';
// import 'package:login_screen/student/widgets/subject_item.dart';
// import 'package:login_screen/data/categories.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: primaryClr,
//       drawer: DrawerWidget(),
//       body: Column(children: [
//         Container(
//           padding: const EdgeInsets.all(5),
//           color: secondaryClr,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Welcome \$man",
//                 style: TextStyle(color: Colors.deepOrange),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/LoginScreen');
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back_ios_rounded,
//                       color: Colors.deepOrange,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: size.height * 0.05,
//           child: Stack(
//             overflow: Overflow.visible,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: size.height * 0.15,
//                 decoration: const BoxDecoration(
//                   // color: secondaryClr,
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.elliptical(190, 180),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: size.height * 0.85,
//           child: GridView(
//             padding: const EdgeInsets.all(10),
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 200,
//               childAspectRatio: 3 / 2,
//               crossAxisSpacing: 20,
//               mainAxisSpacing: 20,
//             ),
//             children: Categories.map((e) => CategoryItem(
//                 e.id ?? '', e.title ?? '', e.color ?? Colors.purple,e.route??'/')).toList(),
//           ),
//         ),
//       ]),
//     );
//   }
// }
