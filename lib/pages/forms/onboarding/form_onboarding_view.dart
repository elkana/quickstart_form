import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'form_onboarding_controller.dart';

class FormOnBoardingBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FormOnBoardingController>(() => FormOnBoardingController());
}

class FormOnBoardingView extends GetView<FormOnBoardingController> {
  const FormOnBoardingView({Key? key}) : super(key: key);
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
            // initialValue: const {
            //   'movie_rating': 5,
            //   'best_language': 'Dart',
            //   'age': '13',
            //   'gender': 'Male',
            //   'languages_filter': ['Dart']
            // },
            skipDisabled: true,
            child: 'Wait'.text.make()),
        [
          ElevatedButton(child: 'Submit'.text.white.make(), onPressed: controller.submit).expand(),
          OutlinedButton(
                  child: 'Reset'.text.color(Theme.of(context).colorScheme.secondary).make(),
                  onPressed: controller.reset)
              .expand(),
        ].row(alignment: MainAxisAlignment.spaceEvenly),
      ].column().scrollVertical().p12());
}
