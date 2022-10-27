import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'form_onboarding_personal_controller.dart';

class FormOnBoardingPersonalBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FormOnBoardingPersonalController>(() => FormOnBoardingPersonalController());
}

class FormOnBoardingPersonalView extends GetView<FormOnBoardingPersonalController> {
  const FormOnBoardingPersonalView({Key? key}) : super(key: key);
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
              'Info Personal'.text.xl.make().card.make(),
              FormBuilderTextField(name: 'id_card', decoration: const InputDecoration(labelText: 'ID KTP')),
              FormBuilderTextField(name: 'fullName', decoration: const InputDecoration(labelText: 'Nama Lengkap')),
              FormBuilderTextField(name: 'idCardAddress', decoration: const InputDecoration(labelText: 'Alamat KTP')),
              [
                FormBuilderTextField(name: 'idCardBirthPlace', decoration: const InputDecoration(labelText: 'Tempat'))
                    .expand(),
                const SizedBox(width: 12),
                FormBuilderDateTimePicker(
                  name: 'idCardBirthDate',
                  decoration: const InputDecoration(labelText: 'Tanggal Lahir'),
                  inputType: InputType.date,
                ).expand(),
              ].row(),
              FormBuilderTextField(name: 'idCardKecamatan', decoration: const InputDecoration(labelText: 'Kecamatan')),
              FormBuilderTextField(name: 'idCardKelurahan', decoration: const InputDecoration(labelText: 'Kelurahan')),
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
              FormBuilderTextField(
                  name: 'maidenName', decoration: const InputDecoration(labelText: 'Nama Ibu Kandung')),
              FormBuilderRadioGroup<String>(
                  name: 'education',
                  decoration: const InputDecoration(labelText: 'Pendidikan Terakhir'),
                  initialValue: null,
                  onChanged: controller.formOnChanged,
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  options: ['SD', 'SMP', 'SMA', 'S1', 'Lainnya']
                      .map((val) => FormBuilderFieldOption(
                            value: val,
                            child: val.text.make().pOnly(left: 8),
                          ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.trailing),
              [
                FormBuilderRadioGroup<String>(
                        name: 'status',
                        decoration: const InputDecoration(labelText: 'Status'),
                        initialValue: null,
                        onChanged: controller.formOnChanged,
                        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                        options: controller.statusOptions
                            .map((val) => FormBuilderFieldOption(
                                  value: val,
                                  child: val.text.make().pOnly(left: 8),
                                ))
                            .toList(growable: false),
                        controlAffinity: ControlAffinity.trailing)
                    .expand(),
                const SizedBox(width: 12),
                // contoh custom field pakai component lain
                // https://medium.com/@danvickmiller/building-a-custom-flutter-form-builder-field-c67e2b2a27f4
                FormBuilderField<int>(
                        name: 'counter',
                        builder: (field) => InputDecorator(
                            decoration: InputDecoration(labelText: 'Jumlah Tanggungan', errorText: field.errorText),
                            child: Align(
                                child: VxStepper(max: 20, defaultValue: field.value ?? 0, onChange: field.didChange),
                                alignment: Alignment.center)),
                        validator: (valueCandidate) => valueCandidate! < 1 ? 'Minimal 1' : null,
                        onChanged: controller.formOnChanged)
                    .expand(),
              ].row(),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              FormBuilderTextField(
                name: 'phone',
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
