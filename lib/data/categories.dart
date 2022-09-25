import 'package:flutter/material.dart';
import 'package:ac_students/data/constant.dart';
import 'package:ac_students/providers/language_provider.dart';
import '../student/models/category.dart';
import '../student/models/season.dart';

const categories = [
  Category(
    title: 'ProfileLabel',
    route: '/ProfileScreen',
    icon: Icons.person_outline_outlined,
  ),
  Category(
    title: 'SettingLabel',
    route: '/SettingScreen',
    icon: Icons.settings_outlined,
  ),
  Category(
    title: 'HomeLabel',
    route: '/HomeScreen',
    icon: Icons.home_outlined,
  ),
  Category(
    title: 'SubjectsLabel',
    route: '/SubjectsScreen',
    icon: Icons.file_copy_outlined,
  ),
  Category(
    title: 'ChatLabel',
    route: '/ChatScreen',
    icon: Icons.chat_bubble_outline,
  ),
  Category(
    title: 'GalleryLabel',
    route: '/GalleryScreen',
    icon: Icons.list_alt,
  ),
  Category(
    title: 'MarksLabel',
    route: '/MarksScreen',
    icon: Icons.insert_drive_file_outlined,
  ),
  Category(
    title: 'NewsLabel',
    route: '/NewsScreen',
    icon: Icons.textsms_outlined,
  ),
  Category(
    title: 'ReportLabel',
    route: '/ReportScreen',
    icon: Icons.report_problem_outlined,
  ),
  Category(
    title: 'AboutLabel',
    route: '/AboutScreen',
    icon: Icons.info_outline,
  ),

  Category(
    title: 'AddFileLabel',
    route: '/AddFileScreen',
    icon: Icons.file_open_outlined,
    isForAdmin: true,
  ),
  Category(
    title: 'AddNewsLabel',
    route: '/AddNewsScreen',
    icon: Icons.add_comment_outlined,
    isForAdmin: true,
  ),
  Category(
    title: 'AddPhotoLabel',
    route: '/AddPhotoScreen',
    icon: Icons.add_a_photo_outlined,
    isForAdmin: true,
  ),
  Category(
    title: 'AddMarksLabel',
    route: '/AddMarksScreen',
    icon: Icons.file_copy_outlined,
    isForAdmin: true,
  ),
  Category(
    title: 'DeleteLabel',
    route: '/DeleteScreen',
    icon: Icons.delete_outline,
    isForAdmin: true,
  ),
  Category(
    title: 'ReportListLabel',
    route: '/ReportsListScreen',
    icon: Icons.list_outlined,
    isForAdmin: true,
  ),

];
//---------seasons
const Semesters = [
  Season(
    id: 's1',
    title: 'Semester 1',
    color: Colors.black54,
  ),
  Season(
    id: 's2',
    title: 'Semester 2',
    color: Colors.black54,
  ),
];
