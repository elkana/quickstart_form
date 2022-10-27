import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'form_onboarding_job_controller.dart';

class FormOnBoardingJobBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FormOnBoardingJobController>(() => FormOnBoardingJobController());
}

class FormOnBoardingJobView extends GetView<FormOnBoardingJobController> {
  const FormOnBoardingJobView({Key? key}) : super(key: key);
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
              'Info Pekerjaan'.text.xl.make().card.make(),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'industri',
                  decoration: InputDecoration(
                      labelText: 'Nama Bank',
                      suffix: controller.industriHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.industriOptions
                      .map((val) =>
                          DropdownMenuItem(alignment: AlignmentDirectional.center, child: val.text.make(), value: val))
                      .toList(),
                  onChanged: (val) => controller
                      .industriHasError(!(controller.formKey.currentState?.fields['industri']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'jobType',
                  decoration: InputDecoration(
                      labelText: 'Tipe Pekerjaan',
                      suffix: controller.industriHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.industriOptions
                      .map((val) =>
                          DropdownMenuItem(alignment: AlignmentDirectional.center, child: val.text.make(), value: val))
                      .toList(),
                  onChanged: (val) => controller
                      .industriHasError(!(controller.formKey.currentState?.fields['jobType']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'jabatan',
                  decoration: InputDecoration(
                      labelText: 'Posisi',
                      suffix: controller.industriHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.industriOptions
                      .map((val) =>
                          DropdownMenuItem(alignment: AlignmentDirectional.center, child: val.text.make(), value: val))
                      .toList(),
                  onChanged: (val) => controller
                      .industriHasError(!(controller.formKey.currentState?.fields['jabatan']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderTextField(name: 'company', decoration: const InputDecoration(labelText: 'Nama Perusahaan')),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'salary',
                  decoration: InputDecoration(
                      labelText: 'Besaran Gaji',
                      suffix: controller.industriHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.industriOptions
                      .map((val) =>
                          DropdownMenuItem(alignment: AlignmentDirectional.center, child: val.text.make(), value: val))
                      .toList(),
                  onChanged: (val) => controller
                      .industriHasError(!(controller.formKey.currentState?.fields['salary']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderTextField(
                name: 'phoneOffice',
                decoration: const InputDecoration(labelText: 'No. Telp. Kantor'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              'Info Kontak'.text.xl.make().card.make(),
              FormBuilderTextField(
                name: 'contact1',
                decoration: const InputDecoration(labelText: 'Nama Kontak 1'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'relation1',
                  decoration: InputDecoration(
                      labelText: 'Hubungan',
                      suffix: controller.relationHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.relationOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) => controller
                      .relationHasError(!(controller.formKey.currentState?.fields['relation1']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderTextField(
                name: 'phoneContact1',
                decoration: const InputDecoration(labelText: 'No. Handphone (+62)'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'contact2',
                decoration: const InputDecoration(labelText: 'Nama Kontak 2'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'relation2',
                  decoration: InputDecoration(
                      labelText: 'Hubungan',
                      suffix: controller.relationHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.relationOptions
                      .map((val) =>
                          DropdownMenuItem(alignment: AlignmentDirectional.center, child: val.text.make(), value: val))
                      .toList(),
                  onChanged: (val) => controller
                      .relationHasError(!(controller.formKey.currentState?.fields['relation2']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderTextField(
                name: 'phoneContact2',
                decoration: const InputDecoration(labelText: 'No. Handphone (+62)'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
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
