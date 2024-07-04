import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../core/widget/awesome_dialog.dart';
class TeacherController extends GetxController{
  CollectionReference dataTeacher = FirebaseFirestore.instance.collection('teachers');
  CollectionReference dataCourse = FirebaseFirestore.instance.collection('courses');
  CollectionReference dataReviewTeacher = FirebaseFirestore.instance.collection('teacher_review');
  CollectionReference dataStudentCourses = FirebaseFirestore.instance.collection('student_courses');

  Future<void> updateActive(context, String id, bool active) {
    return dataTeacher
        .doc(id)
        .update({'active': active ? false : true}).then((value) {
      update();
      return snackBarDialog(context, 'تم العملية بنجاح');
    }).catchError((error) {
      return  snackBarDialog(context, 'هناك خطاء لم يتم تنفيذ العملية');
    });
  }

  void deleteTeacher(context , String id) async {
    await dataTeacher.doc(id).delete().whenComplete(() {
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