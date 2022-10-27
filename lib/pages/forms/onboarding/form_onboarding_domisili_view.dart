import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'form_onboarding_domisili_controller.dart';

class FormOnBoardingDomisiliBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FormOnBoardingDomisiliController>(() => FormOnBoardingDomisiliController());
}

class FormOnBoardingDomisiliView extends GetView<FormOnBoardingDomisiliController> {
  const FormOnBoardingDomisiliView({Key? key}) : super(key: key);
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
              'Info Alamat Domisili'.text.xl.make().card.make(),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'province',
                  decoration: InputDecoration(
                      labelText: 'Propinsi',
                      suffix: controller.propinsiHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.propinsiOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) => controller
                      .propinsiHasError(!(controller.formKey.currentState?.fields['province']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'city',
                  decoration: InputDecoration(
                      labelText: 'Kota',
                      suffix: controller.propinsiHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.kotaOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) => controller
                      .propinsiHasError(!(controller.formKey.currentState?.fields['city']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'kecamatan',
                  decoration: InputDecoration(
                      labelText: 'Kecamatan',
                      suffix: controller.kecamatanHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.kecamatanOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) => controller
                      .kecamatanHasError(!(controller.formKey.currentState?.fields['kecamatan']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'kelurahan',
                  decoration: InputDecoration(
                      labelText: 'Kelurahan',
                      suffix: controller.kelurahanHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.kelurahanOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) => controller
                      .kelurahanHasError(!(controller.formKey.currentState?.fields['kelurahan']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderTextField(name: 'address', decoration: const InputDecoration(labelText: 'Alamat')),
              [
                FormBuilderTextField(name: 'idCardRT', decoration: const InputDecoration(labelText: 'RT'))
                    .box
                    .width(100)
                    .make(),
                const SizedBox(width: 12),
                FormBuilderTextField(name: 'idCardRW', decoration: const InputDecoration(labelText: 'RW'))
                    .box
                    .width(100)
                    .make(),
              ].row(),
              FormBuilderTextField(name: 'statusRumah', decoration: const InputDecoration(labelText: 'Status Rumah')),
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
