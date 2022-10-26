import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/screen_util.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  final formKey = GlobalKey<FormState>();
  final ctrlUserId = TextEditingController();
  final ctrlPwd = TextEditingController();
  var obscurePwd = true.obs;
  var rememberPwd = false.obs;
  var loading = false.obs;

  String? validateUserId(String? value) {
    if (GetUtils.isLengthLessThan(value, 4)) return 'Length must be of 4 chars';
    if (!GetUtils.isEmail(value!)) return 'Invalid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (GetUtils.isLengthLessThan(value, 6)) {
      return 'Password must be of 6 chars';
    }
    return null;
  }

  Future<void> doLoginWithEmail() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();

    loading(true);
    try {
      // final user = await AuthController.instance
      //     .loginWithEmail(ctrlUserId.text, ctrlPwd.text, rememberPwd.value)
      //     .onError((error, stackTrace) {
      //   ScreenUtil.showToast(error.toString(), error: true, title: 'Login Failed');
      //   return null;
      // });

      // if (user == null) return;
    } catch (e, s) {
      ScreenUtil.showError(e, stacktrace: s);
    } finally {
      loading(false);
    }
  }

  void test(String userId, String pwd) {
    ctrlPwd.text = pwd;
    ctrlUserId.text = userId;
  }
}
