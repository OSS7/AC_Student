import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:ac_students/student/models/subject.dart';

class Subjects extends ChangeNotifier {
  final box = GetStorage();

  bool isFirstSem = true;
  List<Subject> subjects = [];
  List<Subject> downloadedSubjects = [];
  int? selectedSubject = 1;

  homeChangeSem() {
    isFirstSem = !isFirstSem;
    notifyListeners();
  }


  subjectChangeSem(int? selected) {
    selectedSubject = selected;
    notifyListeners();
  }


  Future getSubjects() async {
    box.read('download_subjects') == null
        ? null
        : downloadedSubjects = Subject.decode(box.read('download_subjects'));
    // final dep = box.read('department');

    if (box.read('subjects') == null ) {
      final QueryBuilder<ParseObject> subjectQuery =
      QueryBuilder<ParseObject>(ParseObject('Subjects'));
      ParseResponse subjectApiResponse = await subjectQuery.query();
      box.write('subjects', subjectApiResponse.results.toString());
      notifyListeners();
    }
    subjects = Subject.decode(box.read('subjects').toString());
  }

  List<Subject> subjectsForHomeScreen({required int userYear, required int userDep}) {
    // int userYear = box.read('year');
    // int userDep = box.read('department');
    return isFirstSem
        ? subjects
            .where((element) =>
                element.season == 1 &&
                element.year == userYear &&
                element.department == userDep)
            .toList()
        : subjects
            .where((element) =>
                element.season == 2 &&
                element.year == userYear &&
                element.department == userDep)
            .toList();
  }

  List<Subject> subjectsForSubjectsScreen({required int userYear, required int userDep}) {
    // int userYear = box.read('year');
    // int userDep = box.read('department');
    return selectedSubject == 1
        ? subjects
            .where((element) =>
                element.season == 1 &&
                element.year == userYear &&
                element.department == userDep)
            .toList()
        : selectedSubject == 2
            ? subjects
                .where((element) =>
                    element.season == 2 &&
                    element.year == userYear &&
                    element.department == userDep)
                .toList()
            : downloadedSubjects;
  }

  bool isDownloadedSubject(int? id) {
    List<Subject> subjects =
        downloadedSubjects.where((element) => element.id == id).toList();
    return subjects.isNotEmpty ? true : false;
  }

  downloadedSubjectAddRemove(Subject subject) {
    List<Subject> subjects = downloadedSubjects
        .where((element) => element.id == subject.id)
        .toList();
    subjects.isNotEmpty
        ? downloadedSubjects.remove(downloadedSubjects
            .firstWhere((element) => element.id == subject.id))
        : downloadedSubjects.add(subject);
    box.write('download_subjects', Subject.encode(downloadedSubjects));
    notifyListeners();
  }
}
