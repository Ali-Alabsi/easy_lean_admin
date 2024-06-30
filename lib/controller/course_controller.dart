import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/widget/awesome_dialog.dart';

class CoursesController extends GetxController {
  CollectionReference dataCourses =
      FirebaseFirestore.instance.collection('courses');

  Future<void> updateActive(context, String id, bool active) {
    return dataCourses
        .doc(id)
        .update({'active': active ? false : true}).then((value) {
      update();
      return snackBarDialog(context, 'تم العملية بنجاح');
    }).catchError((error) {
      return  snackBarDialog(context, 'هناك خطاء لم يتم تنفيذ العملية');
    });
  }

  void deleteCourse(context , String id) async {
    await dataCourses.doc(id).delete().whenComplete(() {
      update();
      snackBarDialog(context, 'تم العملية  الحذف بنجاح');
    }).onError((error, stackTrace) {
      snackBarDialog(context, ' هناك خطاء لم تتم عملية الحذف');
    });
  }
}
