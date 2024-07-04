import 'package:easy_lean_admin/controller/login_contoller.dart';
import 'package:easy_lean_admin/core/shared/controller.dart';
import 'package:easy_lean_admin/core/widget/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/shared/color.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/widget/app_text_form_filed.dart';
import '../../core/widget/button.dart';
import 'layout.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controllerPut = Get.put(LoginController());
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: double.infinity,
          // margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: ProjectColors.mainColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                height: 420,
                width: 450,
                decoration: BoxDecoration(
                    color: ProjectColors.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Form(
                      key: controllerPut.loginForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تسجيل الدخول',
                            style: TextStyles.font20mainColorBold,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          AppTextFormFiled(
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'الرجاء إدخال رقم المستخدم';
                              }
                              return null;
                            },
                            hintText: 'رقم المستخدم ',
                            controller: MyController.emailLogin,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppTextFormFiled(
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'الرجاء إدخال كلمة المرور';
                              }
                              return null;
                            },
                            hintText: 'كلمة المرور',
                            controller: MyController.passwordLogin,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GetBuilder<LoginController>(
                              init: LoginController(),
                              builder: (controller) {
                                return FutureBuilder(
                                    future: controller.dataAdmin.get(),
                                    builder: (context, snapshot) {
                                      return controller.isLoadingLogin ? CircularProgressIndicator():  MainButton(
                                        name: 'تسجيل الدخول',
                                        onPressed: () {
                                          if (controllerPut.loginForm.currentState!.validate()) {
                                            controller.changeLoadingIsTrue();
                                            for (int i = 0; i < snapshot.data!.docs.length; i++) {
                                              if (snapshot.data!.docs[i]['id'] == MyController.emailLogin.text &&
                                                  snapshot.data!.docs[i]['password'] ==MyController.passwordLogin.text) {
                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Layout()),
                                                        (Route<dynamic> route) => false);
                                                controller.changeLoadingIsFalse();
                                                break;
                                              }
                                              snackBarDialog(context, 'اسم المستخدم او كلمة المرور خاطئة');
                                            }

                                            controller.changeLoadingIsFalse();
                                          }
                                        },
                                        margin: EdgeInsetsDirectional.zero,
                                      );
                                    });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Text(
                      'Easy Lean',
                      style: TextStyles.font22WhiteBold,
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
