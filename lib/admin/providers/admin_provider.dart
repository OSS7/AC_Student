import 'package:flutter/material.dart';

class AdminProvider extends ChangeNotifier{
  int selectedSubject = 1;
  int subjectId = 1;
  int selectedDep = 1;

  selectSubject(int index){
    selectedSubject = index;
    notifyListeners();
  }

  changeSubjectId(int id){
    subjectId = id;
    notifyListeners();
  }

  changeDepartment(){
    selectedDep == 1 ? selectedDep = 2 : selectedDep = 1;
    notifyListeners();
  }

}