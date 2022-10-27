import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quickstart_form/utils/commons.dart';

class FormOnBoardingJobController extends GetxController {
  static FormOnBoardingJobController instance = Get.find();
  final formKey = GlobalKey<FormBuilderState>();
  var salaryHasError = false.obs;
  var jabatanHasError = false.obs;
  var jobTypeHasError = false.obs;
  var industriHasError = false.obs;
  var relationHasError = false.obs;
  var salaryOptions = ['< 5 juta'];
  var jabatanOptions = ['Manager'];
  var jobTypeOptions = ['IT'];
  var industriOptions = ['Government'];
  var relationOptions = ['Pasangan Suami/Istri', 'Adik'];

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
