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
                const SizedBox(height: 20),
                // email
                TextFormField(
                    controller: controller.ctrlUserId,
                    textAlign: TextAlign.center,
                    validator: controller.validateUserId,
                    onSaved: (val) => controller.ctrlUserId.text = val!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    autofocus: false,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        suffixIcon: SizedBox(),
                        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0))),
                //password
                Obx(() => TextFormField(
                    controller: controller.ctrlPwd,
                    textAlign: TextAlign.center,
                    validator: controller.validatePassword,
                    onSaved: (val) => controller.ctrlPwd.text = val!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(controller.obscurePwd.isTrue
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () => controller.obscurePwd.toggle()),
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0)),
                    obscureText: controller.obscurePwd.value)),
                // toggle rememberme
                Row(children: [
                  TextButton.icon(
                      label: LocaleKeys.buttons_rememberme.tr.text.xs.make(),
                      icon: Obx(() => Switch(
                          value: controller.rememberPwd.value, onChanged: (val) => controller.rememberPwd.toggle())),
                      onPressed: controller.rememberPwd.toggle),
                  const Spacer(),
                  TextButton(child: 'Forgot Password'.text.xs.make(), onPressed: () => Get.toNamed(Routes.formResetPwd))
                ]),
                const SizedBox(height: 10.0),
                //button login
                Obx(() => controller.loading.isTrue
                    ? const CircularProgressIndicator()
                    : MyButton('Log in', onTap: controller.doLoginWithEmail).py16()),
                const Spacer(),
                TextButton(
                    child: 'New User ? Sign-up here'.text.xs.make(), onPressed: () => Get.toNamed(Routes.formSignUp))
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
