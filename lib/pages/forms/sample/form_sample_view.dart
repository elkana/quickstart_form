import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'form_sample_controller.dart';

class FormSampleBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FormSampleController>(() => FormSampleController());
}

// mostly copas from https://pub.dev/packages/flutter_form_builder/example
class FormSampleView extends GetView<FormSampleController> {
  const FormSampleView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Form Sample Example')),
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
              'movie_rating': 5,
              'best_language': 'Dart',
              'age': '13',
              'gender': 'Male',
              'languages_filter': ['Dart']
            },
            skipDisabled: true,
            child: [
              const SizedBox(height: 15),
              FormBuilderDateTimePicker(
                name: 'date',
                initialEntryMode: DatePickerEntryMode.calendar,
                initialValue: DateTime.now(),
                inputType: InputType.both,
                decoration: InputDecoration(
                    labelText: 'Appointment Time',
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => controller.formKey.currentState!.fields['date']?.didChange(null))),
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                // locale: const Locale.fromSubtags(languageCode: 'fr'),
              ),
              FormBuilderDateRangePicker(
                  name: 'date_range',
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2030),
                  format: DateFormat('yyyy-MM-dd'),
                  onChanged: controller.formOnChanged,
                  decoration: InputDecoration(
                      labelText: 'Date Range',
                      helperText: 'Helper text',
                      hintText: 'Hint text',
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => controller.formKey.currentState!.fields['date_range']?.didChange(null)))),
              FormBuilderSlider(
                  name: 'slider',
                  decoration: const InputDecoration(labelText: 'Number of things'),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.min(6)]),
                  min: 0.0,
                  max: 10.0,
                  initialValue: 7.0,
                  divisions: 20,
                  activeColor: Colors.red,
                  inactiveColor: Colors.pink[100],
                  onChanged: controller.formOnChanged),
              FormBuilderRangeSlider(
                name: 'range_slider',
                // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
                onChanged: controller.formOnChanged,
                min: 0.0,
                max: 100.0,
                initialValue: const RangeValues(4, 7),
                divisions: 20,
                activeColor: Colors.red,
                inactiveColor: Colors.pink[100],
                decoration: const InputDecoration(labelText: 'Price Range'),
              ),
              FormBuilderCheckbox(
                  name: 'accept_terms',
                  initialValue: false,
                  onChanged: controller.formOnChanged,
                  title: RichText(
                      text: const TextSpan(children: [
                    TextSpan(text: 'I have read and agree to the ', style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: TextStyle(color: Colors.blue),
                      // Flutter doesn't allow a button inside a button
                      // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                      /*
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('launch url');
                            },
                          */
                    ),
                  ])),
                  validator:
                      FormBuilderValidators.equal(true, errorText: 'You must accept terms and conditions to continue')),
              Obx(() => FormBuilderTextField(
                  name: 'age',
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    suffixIcon: controller.ageHasError.isTrue
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  onChanged: (val) =>
                      controller.ageHasError(!(controller.formKey.currentState?.fields['age']?.validate() ?? false)),
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.max(70),
                  ]),
                  // initialValue: '12',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next)),
              Obx(() => FormBuilderDropdown<String>(
                  // autovalidate: true,
                  name: 'gender',
                  decoration: InputDecoration(
                      labelText: 'Gender',
                      hintText: 'Select Gender',
                      suffix: controller.genderHasError.isTrue ? const Icon(Icons.error) : const Icon(Icons.check)),
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  items: controller.genderOptions
                      .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center, child: gender.text.make(), value: gender))
                      .toList(),
                  onChanged: (val) => controller
                      .genderHasError(!(controller.formKey.currentState?.fields['gender']?.validate() ?? false)),
                  valueTransformer: (val) => val?.toString())),
              FormBuilderRadioGroup<String>(
                  name: 'best_language',
                  decoration: const InputDecoration(labelText: 'My chosen language'),
                  initialValue: null,
                  onChanged: controller.formOnChanged,
                  validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                  options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                      .map((lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text(lang),
                          ))
                      .toList(growable: false),
                  controlAffinity: ControlAffinity.trailing),
              FormBuilderSegmentedControl(
                  name: 'movie_rating',
                  decoration: const InputDecoration(labelText: 'Movie Rating (Archer)'),
                  // initialValue: 1,
                  // textStyle: TextStyle(fontWeight: FontWeight.bold),
                  options: List.generate(5, (i) => i + 1)
                      .map((number) => FormBuilderFieldOption(child: Text(number.toString()), value: number))
                      .toList(),
                  onChanged: controller.formOnChanged),
              FormBuilderSwitch(
                  name: 'accept_terms_switch',
                  title: 'I Accept the terms and conditions'.text.make(),
                  initialValue: true,
                  onChanged: controller.formOnChanged),
              FormBuilderCheckboxGroup<String>(
                  name: 'languages',
                  decoration: const InputDecoration(labelText: 'The language of my people'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // initialValue: const ['Dart'],
                  options: const [
                    FormBuilderFieldOption(value: 'Dart'),
                    FormBuilderFieldOption(value: 'Kotlin'),
                    FormBuilderFieldOption(value: 'Java'),
                    FormBuilderFieldOption(value: 'Swift'),
                    FormBuilderFieldOption(value: 'Objective-C'),
                  ],
                  onChanged: controller.formOnChanged,
                  separator: const VerticalDivider(width: 10, thickness: 5, color: Colors.red),
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.minLength(1), FormBuilderValidators.maxLength(3)])),
              // FormBuilderFilterChip<String>(
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   decoration: const InputDecoration(labelText: 'The language of my people'),
              //   name: 'languages_filter',
              //   selectedColor: Colors.red,
              //   options: [
              //     FormBuilderChoiceChip(
              //       name: 'dart',
              //       value: 'Dart',
              //       avatar: CircleAvatar(child: Text('D')),
              //     ),
              //     FormBuilderChipOption(
              //       value: 'Kotlin',
              //       avatar: CircleAvatar(child: Text('K')),
              //     ),
              //     FormBuilderChipOption(
              //       value: 'Java',
              //       avatar: CircleAvatar(child: Text('J')),
              //     ),
              //     FormBuilderChipOption(
              //       value: 'Swift',
              //       avatar: CircleAvatar(child: Text('S')),
              //     ),
              //     FormBuilderChipOption(
              //       value: 'Objective-C',
              //       avatar: CircleAvatar(child: Text('O')),
              //     ),
              //   ],
              //   onChanged: controller.formOnChanged,
              //   validator: FormBuilderValidators.compose([
              //     FormBuilderValidators.minLength(1),
              //     FormBuilderValidators.maxLength(3),
              //   ]),
              // ),
              FormBuilderChoiceChip<String>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Ok, if I had to choose one language, it would be:'),
                  name: 'languages_choice',
                  initialValue: 'Dart',
                  options: const [
                    FormBuilderFieldOption(
                      value: 'Dart',
                      child: CircleAvatar(child: Text('D')),
                    ),
                    FormBuilderFieldOption(
                      value: 'Kotlin',
                      child: CircleAvatar(child: Text('K')),
                    ),
                    FormBuilderFieldOption(
                      value: 'Java',
                      child: CircleAvatar(child: Text('J')),
                    ),
                    FormBuilderFieldOption(
                      value: 'Swift',
                      child: CircleAvatar(child: Text('S')),
                    ),
                    FormBuilderFieldOption(
                      value: 'Objective-C',
                      child: CircleAvatar(child: Text('O')),
                    ),
                  ],
                  onChanged: controller.formOnChanged),
            ].column()),
        [
          ElevatedButton(
              child: 'Submit'.text.white.make(),
              onPressed: () {
                if (controller.formKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(controller.formKey.currentState?.value.toString());
                } else {
                  debugPrint(controller.formKey.currentState?.value.toString());
                  debugPrint('validation failed');
                }
              }),
          OutlinedButton(
              child: 'Reset'.text.color(Theme.of(context).colorScheme.secondary).make(),
              onPressed: () => controller.formKey.currentState?.reset()),
        ].row(alignment: MainAxisAlignment.spaceBetween),
      ].column().scrollVertical().p12());
}
