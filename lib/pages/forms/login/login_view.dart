import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../configs/locales.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/common.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LoginController>(() => LoginController());
}

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: kReleaseMode
          ? null
          : AppBar(
              actions: [
                TextButton(
                    child: 'Test Offline'.text.make(),
                    onPressed: () => controller.test('offline@yahoo.com', 'offline')),
                TextButton(
                    child: 'Test User 1'.text.make(),
                    onPressed: () => controller.test('elkana911@yahoo.com', 'elkana911'))
              ],
            ),
      body: Form(
              child: [
                'Title'.text.xl4.bold.make(),
                // email
                MyTextFormField('Email',
                    controller: controller.ctrlUserId,
                    validator: (val) => controller.validateUserId(val!),
                    onSaved: (val) => controller.ctrlUserId.text = val!),
                //password
                Obx(() => MyTextFormField(
                      'Password',
                      controller: controller.ctrlPwd,
                      validator: (val) => controller.validatePassword(val!),
                      onSaved: (val) => controller.ctrlPwd.text = val!,
                      obscureText: controller.obscurePwd.value,
                      suffixIcon: IconButton(
                          icon: Icon(
                              controller.obscurePwd.isTrue ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                          onPressed: () => controller.obscurePwd.toggle()),
                    )),
                // toggle rememberme
                [
                  TextButton.icon(
                    label: LocaleKeys.buttons_rememberme.tr.text.sm.make(),
                    onPressed: controller.rememberPwd.toggle,
                    icon: Obx(() => Switch(
                        value: controller.rememberPwd.value, onChanged: (val) => controller.rememberPwd.toggle())),
                  ),
                  const Spacer(),
                  TextButton(child: 'Forgot Password'.text.sm.make(), onPressed: () => Get.toNamed(Routes.formResetPwd))
                ].row(axisSize: MainAxisSize.max),
                //button login
                Obx(() => controller.loading.isTrue
                    ? const CircularProgressIndicator()
                    : MyButton('Log in', onTap: controller.doLoginWithEmail).marginOnly(top: 10)),
                TextButton(
                    child: 'New User ? Sign up here'.text.sm.make(),
                    onPressed: () => Get.toNamed(Routes.formSignUp)).marginOnly(top: 10),
                const Spacer(),
                'By signing in, you agree to our terms and conditions.'.text.sm.make()
              ].column(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.formKey)
          .box
          .width(300)
          .height(400)
          .make()
          .scrollVertical()
          .centered());
}
