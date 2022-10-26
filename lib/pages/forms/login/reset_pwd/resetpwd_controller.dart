import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/screen_util.dart';

class ResetPwdController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController ctrlUserId;
  var obscurePwdNew = true.obs;
  var obscurePwdConfirm = true.obs;
  var rememberPwd = false.obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ctrlUserId = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    ctrlUserId.dispose();
  }

  String? validateUserId(String value) {
    if (GetUtils.isLengthLessThan(value, 4)) return 'Length must be of 4 chars';
    if (!GetUtils.isEmail(value)) return 'Invalid email';
    return null;
  }

  Future<void> doResetPwd() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();

    loading(true);

    try {
      await 3.delay();
    } catch (e, s) {
      ScreenUtil.showError(e, stacktrace: s);
    } finally {
      loading(false);
    }
  }
}
