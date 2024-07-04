import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/shared/controller.dart';
import '../core/widget/awesome_dialog.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginForm = GlobalKey();
  CollectionReference dataAdmin =
  FirebaseFirestore.instance.collection('admin');
  bool isLoadingLogin = false;
  changeLoadingIsTrue(){
    isLoadingLogin = true;
    update();
  }



  changeLoadingIsFalse(){
    isLoadingLogin = false;
    update();
  }
}