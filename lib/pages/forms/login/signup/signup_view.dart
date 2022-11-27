import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../widgets/common.dart';
import 'signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<SignUpController>(() => SignUpController());
}

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: 'Register'.text.make(),
        actions: [
          Visibility(
              child: TextButton(onPressed: controller.test('elkana911', 'elkana911'), child: const Text('Test User 1')),
              visible: !kReleaseMode)
        ],
      ),
      body: Form(
              child: [
                // full name
                MyTextFormField('Full name',
                    controller: controller.ctrlFullname,
                    validator: (val) => controller.validateFullname(val!),
                    onSaved: (val) => controller.ctrlFullname.text = val!),
                // email
                MyTextFormField('Email',
                    controller: controller.ctrlUserId,
                    validator: (val) => controller.validateUserId(val!),
                    onSaved: (val) => controller.ctrlUserId.text = val!),
                //password
                Obx(() => MyTextFormField(
                      'New Password',
                      controller: controller.ctrlNewPwd,
                      validator: (val) => controller.validatePassword(val!),
                      onSaved: (val) => controller.ctrlNewPwd.text = val!,
                      obscureText: controller.obscurePwdNew.value,
                      suffixIcon: IconButton(
                          icon: Icon(controller.obscurePwdNew.isTrue
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () => controller.obscurePwdNew.toggle()),
                    )),
                //confirm password
                Obx(() => MyTextFormField(
                      'Confirm Password',
                      controller: controller.ctrlConfirmPwd,
                      validator: (val) => controller.validatePassword(val!),
                      onSaved: (val) => controller.ctrlConfirmPwd.text = val!,
                      obscureText: controller.obscurePwdConfirm.value,
                      suffixIcon: IconButton(
                          icon: Icon(controller.obscurePwdConfirm.isTrue
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () => controller.obscurePwdConfirm.toggle()),
                    )),
                //button login
                Obx(() => controller.loading.isTrue
                    ? const CircularProgressIndicator()
                    : MyButton('Register', onTap: controller.doSignUp).marginOnly(top: 10)).marginOnly(top: 20),
                const Spacer(),
                'By registering, you agree to our terms and conditions.'.text.sm.make()
              ].column(),
              key: controller.formKey)
          .box
          .width(300)
          .height(420)
          .make()
          .scrollVertical()
          .centered());
}
