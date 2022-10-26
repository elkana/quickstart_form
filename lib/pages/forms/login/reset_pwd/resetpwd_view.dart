import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'resetpwd_controller.dart';

class ResetPwdBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<ResetPwdController>(() => ResetPwdController());
}

class ResetPwdView extends GetView<ResetPwdController> {
  const ResetPwdView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
          child: SingleChildScrollView(
              child: SizedBox(
                  child: Form(
                      child: Column(children: <Widget>[
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
                        const Text('A reset link will be sent to your email'),
                        //button login
                        Obx(() => controller.loading.value
                            ? const CircularProgressIndicator()
                            : Padding(
                                child: Material(
                                    child: MaterialButton(
                                        child: const Text('Reset My Password', style: TextStyle(color: Colors.white)),
                                        onPressed: controller.doResetPwd,
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
