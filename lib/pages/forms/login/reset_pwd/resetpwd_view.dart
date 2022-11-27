import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../widgets/common.dart';
import 'resetpwd_controller.dart';

class ResetPwdBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<ResetPwdController>(() => ResetPwdController());
}

class ResetPwdView extends GetView<ResetPwdController> {
  const ResetPwdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: 'Forgot Password'.text.make()),
      body: Form(
              child: [
                // email
                MyTextFormField('Email',
                    controller: controller.ctrlUserId,
                    validator: (val) => controller.validateUserId(val!),
                    onSaved: (val) => controller.ctrlUserId.text = val!),
                const Text('A reset link will be sent to your email'),
                //button login
                Obx(() => controller.loading.isTrue
                    ? const CircularProgressIndicator()
                    : MyButton('Reset Password', onTap: controller.doResetPwd)).marginOnly(top: 10)
              ].column(),
              key: controller.formKey)
          .box
          .width(300)
          .make()
          .scrollVertical()
          .centered());
}
