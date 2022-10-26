import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class FormOnBoardingController extends GetxController {
  static FormOnBoardingController instance = Get.find();
  final formKey = GlobalKey<FormBuilderState>();
  var ageHasError = false.obs;
  var genderHasError = false.obs;
  var genderOptions = ['Male', 'Female', 'Other'];

  void formOnChanged(dynamic val) => debugPrint(val.toString());

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
