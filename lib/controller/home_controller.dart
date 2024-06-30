import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  CollectionReference dataCourses  = FirebaseFirestore.instance.collection('courses');
  CollectionReference dataApp  = FirebaseFirestore.instance.collection('app');
  CollectionReference dataAdmin  = FirebaseFirestore.instance.collection('admin');
}