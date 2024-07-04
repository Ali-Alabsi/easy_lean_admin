import 'package:easy_lean_admin/view/screen/courses/courses.dart';
import 'package:easy_lean_admin/view/screen/home.dart';
import 'package:easy_lean_admin/view/screen/student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/courses/courses_details.dart';
import '../view/screen/project.dart';
import '../view/screen/teacher/teacher.dart';

class LayoutController extends GetxController{
  int indexScreen =0;
  List<Widget> screen=[
    Home(),
    Courses(),
    Teacher(),
    Project(),
    Student(),
    // CoursesDetails()
  ];
  changeIndexScreen(int i){
    indexScreen =i;
    update();
  }
}