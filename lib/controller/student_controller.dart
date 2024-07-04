import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_lean_admin/core/widget/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StudentController extends GetxController{
  CollectionReference dataStudents = FirebaseFirestore.instance.collection('users');
  CollectionReference dataTeacher = FirebaseFirestore.instance.collection('teachers');
  CollectionReference dataCourse = FirebaseFirestore.instance.collection('courses');
  CollectionReference dataReviewTeacher = FirebaseFirestore.instance.collection('teacher_review');
  CollectionReference dataStudentCourses = FirebaseFirestore.instance.collection('student_courses');
  void deleteStudent(context , String id) async {
    await dataStudents.doc(id).delete().whenComplete(() {
      update();
      snackBarDialog(context, 'تم العملية  الحذف بنجاح');
    }).onError((error, stackTrace) {
      snackBarDialog(context, ' هناك خطاء لم تتم عملية الحذف');
    });
  }
  void deleteReview(context , String id) async {
    await dataReviewTeacher.doc(id).delete().whenComplete(() {
      update();
      snackBarDialog(context, 'تم العملية  الحذف بنجاح');
    }).onError((error, stackTrace) {
      snackBarDialog(context, ' هناك خطاء لم تتم عملية الحذف');
    });
  }
}

