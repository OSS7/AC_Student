import 'package:ac_students/core/constant/categories.dart';
import 'package:ac_students/core/utils/providers/language_provider.dart';
import 'package:ac_students/core/utils/widgets/custom_logo.dart';
import 'package:ac_students/features/auth/providers/user_provider.dart';
import 'package:ac_students/features/drawer/model/drawer_model.dart';
import 'package:ac_students/features/drawer/widgets/drawer_item.dart';
import 'package:ac_students/features/drawer/widgets/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constant/constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lan = Provider.of<LanguageProvider>(context);
    final user = Provider.of<UserProvider>(context);
    List<DrawerModel> specificCategories = !(user.isAdmin ?? false)
        ? categories.where((element) => element.isForAdmin == false).toList()
        : categories;
    return Drawer(
        child: Directionality(
      textDirection: lan.isAr ? TextDirection.rtl : TextDirection.ltr,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: secondaryClr,
              child: const CustomLogo(),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: ListView.builder(
                  controller: ScrollController(),
                  itemCount: specificCategories.length,
                  itemBuilder: (context, index) {
                    List<DrawerModel> varCategories = specificCategories;
                    DrawerModel varCategory = varCategories[index];
                    return index != 2 && index != 10
                        ? DrawerItem(
                            title: lan.get(varCategory.title.toString()),
                            icon: varCategory.icon,
                            route: varCategory.route,
                          )
                        : Column(
                            children: [
                              index == 2
                                  ? Divider(
                                      color: secondaryClr,
                                      height: 2,
                                      indent: 20,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            lan.get('AdminPanel').toString(),
                                            style: TextStyle(
                                              color: secondaryClr,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                              child: Divider(
                                            color: secondaryClr,
                                            height: 2,
                                            indent: 20,
                                          ))
                                        ],
                                      ),
                                    ),
                              DrawerItem(
                                title: lan.get(varCategory.title.toString()),
                                icon: varCategory.icon,
                                route: varCategory.route,
                              ),
                            ],
                          );
                  },
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryClr, primaryClr.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
            const LogoutButton(),
          ],
        ),
      ),
    ));
  }
}
