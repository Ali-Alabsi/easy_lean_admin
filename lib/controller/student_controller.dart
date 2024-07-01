import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_lean_admin/core/widget/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StudentController extends GetxController{
  CollectionReference dataStudents =
  FirebaseFirestore.instance.collection('users');

  void deleteStudent(context , String id) async {
    await dataStudents.doc(id).delete().whenComplete(() {
      update();
      snackBarDialog(context, 'تم العملية  الحذف بنجاح');
    }).onError((error, stackTrace) {
      snackBarDialog(context, ' هناك خطاء لم تتم عملية الحذف');
    });
  }


}