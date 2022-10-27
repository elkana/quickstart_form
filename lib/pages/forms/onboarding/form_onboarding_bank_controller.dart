import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quickstart_form/utils/commons.dart';

class FormOnBoardingBankController extends GetxController {
  static FormOnBoardingBankController instance = Get.find();
  final formKey = GlobalKey<FormBuilderState>();
  var bankHasError = false.obs;
  var bankOptions = ['BCA', 'Blu BCA', 'Mandiri'];

  void formOnChanged(dynamic val) => log(val.toString());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeDateFormatting(); // must
  }

  void submit() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      debugPrint(formKey.currentState?.value.toString());
    } else {
      debugPrint(formKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }

  void reset() {
    formKey.currentState?.reset();
  }
}
