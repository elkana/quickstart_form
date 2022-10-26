import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('Register'),
        actions: [
          kReleaseMode
              ? const SizedBox()
              : TextButton(onPressed: controller.test('elkana911', 'elkana911'), child: const Text('Test User 1'))
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
              child: SizedBox(
                  child: Form(
                      child: Column(children: <Widget>[
                        // full name
                        TextFormField(
                            controller: controller.ctrlFullname,
                            textAlign: TextAlign.center,
                            validator: (val) => controller.validateFullname(val!),
                            onSaved: (val) => controller.ctrlFullname.text = val!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            autofocus: false,
                            decoration: const InputDecoration(
                                labelText: 'Full name',
                                suffixIcon: SizedBox(),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0))),
                        // email
                        TextFormField(
                            controller: controller.ctrlUserId,
                            textAlign: TextAlign.center,
                            validator: (val) => controller.validateUserId(val!),
                            onSaved: (val) => controller.ctrlUserId.text = val!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            autofocus: false,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                suffixIcon: SizedBox(),
                                contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0))),
                        //password
                        Obx(() => TextFormField(
                            controller: controller.ctrlNewPwd,
                            textAlign: TextAlign.center,
                            validator: (val) => controller.validatePassword(val!),
                            onSaved: (val) => controller.ctrlNewPwd.text = val!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                labelText: 'New Password',
                                suffixIcon: IconButton(
                                    icon: Icon(controller.obscurePwdNew.isTrue
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined),
                                    onPressed: () => controller.obscurePwdNew.toggle()),
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0)),
                            obscureText: controller.obscurePwdNew.value)),
                        //confirm password
                        Obx(() => TextFormField(
                            controller: controller.ctrlConfirmPwd,
                            textAlign: TextAlign.center,
                            validator: (val) => controller.validatePassword(val!),
                            onSaved: (val) => controller.ctrlConfirmPwd.text = val!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                    icon: Icon(controller.obscurePwdConfirm.isTrue
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined),
                                    onPressed: () => controller.obscurePwdConfirm.toggle()),
                                contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0)),
                            obscureText: controller.obscurePwdConfirm.value)),
                        const SizedBox(height: 20),
                        //button login
                        Obx(() => controller.loading.value
                            ? const CircularProgressIndicator()
                            : Padding(
                                child: Material(
                                    child: MaterialButton(
                                        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                                        onPressed: controller.doSignUp,
                                        minWidth: double.infinity,
                                        height: 42.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                    elevation: 5.0,
                                    color: Colors.purple),
                                padding: const EdgeInsets.symmetric(vertical: 16.0))),
                      ]),
                      key: controller.formKey),
                  width: 300))));
}
