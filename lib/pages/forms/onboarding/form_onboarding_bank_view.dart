import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'form_onboarding_bank_controller.dart';

class FormOnBoardingBankBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FormOnBoardingBankController>(() => FormOnBoardingBankController());
}

class FormOnBoardingBankView extends GetView<FormOnBoardingBankController> {
  const FormOnBoardingBankView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Form OnBoarding Example')),
      body: [
        FormBuilder(
            key: controller.formKey,
            // enabled: false,
            onChanged: () {
              controller.formKey.currentState!.save();
              debugPrint(controller.formKey.currentState!.value.toString());
            },
            autovalidateMode: AutovalidateMode.disabled,
            initialValue: const {
              'counter': 9,
              // 'movie_rating': 5,
              // 'best_language': 'Dart',
              // 'age': '13',
              // 'gender': 'Male',
              // 'languages_filter': ['Dart']
            },
            skipDisabled: true,
            child: [
              'Info Data Bank'.text.xl.make().card.make(),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'bank',
                  decoration: InputDecoration(
                      labelText: 'Nama Bank',
                      suffix: controller.bankHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.bankOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) =>
                      controller.bankHasError(!(controller.formKey.currentState?.fields['bank']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderTextField(
                  name: 'custName', decoration: const InputDecoration(labelText: 'Nama Pemilik Rekening')),
              FormBuilderTextField(name: 'accountNo', decoration: const InputDecoration(labelText: 'No. Rekening')),
              FormBuilderTextField(
                  name: 'confirmAccountNo', decoration: const InputDecoration(labelText: 'Ulangi No. Rekening')),
            ].column()),
        [
          ElevatedButton(child: 'Submit'.text.white.make(), onPressed: controller.submit).expand(),
          OutlinedButton(
                  child: 'Reset'.text.color(Theme.of(context).colorScheme.secondary).make(),
                  onPressed: controller.reset)
              .expand(),
        ].row(alignment: MainAxisAlignment.spaceEvenly),
      ].column().scrollVertical().p12());
}
