import 'package:easy_lean_admin/view/screen/courses.dart';
import 'package:easy_lean_admin/view/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screen/project.dart';
import '../view/screen/teacher.dart';

class LayoutController extends GetxController{
  int indexScreen =3;
  List<Widget> screen=[
    Home(),
    Courses(),
    Teacher(),
    Project(),
  ];
  changeIndexScreen(int i){
    indexScreen =i;
    update();
  }
}