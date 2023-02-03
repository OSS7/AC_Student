import 'package:flutter/material.dart';

import '../../features/drawer/model/drawer_model.dart';

const categories = [
  DrawerModel(
    title: 'ProfileLabel',
    route: '/ProfileScreen',
    icon: Icons.person_outline_outlined,
  ),
  DrawerModel(
    title: 'SettingLabel',
    route: '/SettingScreen',
    icon: Icons.settings_outlined,
  ),
  DrawerModel(
    title: 'HomeLabel',
    route: '/HomeScreen',
    icon: Icons.home_outlined,
  ),
  DrawerModel(
    title: 'SubjectsLabel',
    route: '/SubjectsScreen',
    icon: Icons.file_copy_outlined,
  ),
  DrawerModel(
    title: 'ChatLabel',
    route: '/ChatScreen',
    icon: Icons.chat_bubble_outline,
  ),
  DrawerModel(
    title: 'GalleryLabel',
    route: '/GalleryScreen',
    icon: Icons.list_alt,
  ),
  DrawerModel(
    title: 'MarksLabel',
    route: '/MarksScreen',
    icon: Icons.insert_drive_file_outlined,
  ),
  DrawerModel(
    title: 'NewsLabel',
    route: '/NewsScreen',
    icon: Icons.textsms_outlined,
  ),
  DrawerModel(
    title: 'ReportLabel',
    route: '/ReportScreen',
    icon: Icons.report_problem_outlined,
  ),
  DrawerModel(
    title: 'AboutLabel',
    route: '/AboutScreen',
    icon: Icons.info_outline,
  ),
  DrawerModel(
    title: 'AddFileLabel',
    route: '/AddFileScreen',
    icon: Icons.file_open_outlined,
    isForAdmin: true,
  ),
  DrawerModel(
    title: 'AddNewsLabel',
    route: '/AddNewsScreen',
    icon: Icons.add_comment_outlined,
    isForAdmin: true,
  ),
  DrawerModel(
    title: 'AddPhotoLabel',
    route: '/AddPhotoScreen',
    icon: Icons.add_a_photo_outlined,
    isForAdmin: true,
  ),
  DrawerModel(
    title: 'AddMarksLabel',
    route: '/AddMarksScreen',
    icon: Icons.file_copy_outlined,
    isForAdmin: true,
  ),
  DrawerModel(
    title: 'DeleteLabel',
    route: '/DeleteScreen',
    icon: Icons.delete_outline,
    isForAdmin: true,
  ),
  DrawerModel(
    title: 'ReportListLabel',
    route: '/ReportsListScreen',
    icon: Icons.list_outlined,
    isForAdmin: true,
  ),
];
