import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickstart_form/routes/app_routes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<HomeController>(() => HomeController());
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: 'Home of Forms'.text.make(),
          ),
          body: [
            ElevatedButton.icon(
                label: const Text('Forms Sample'),
                onPressed: () => Get.toNamed(Routes.formSample),
                icon: const Icon(Icons.format_list_bulleted_rounded)),
            ElevatedButton.icon(
                label: const Text('Forms OnBoarding Personal'),
                onPressed: () => Get.toNamed(Routes.formOnboardingPersonal),
                icon: const Icon(Icons.format_list_bulleted_rounded)),
            ElevatedButton.icon(
                label: const Text('Forms OnBoarding Job'),
                onPressed: () => Get.toNamed(Routes.formOnboardingJob),
                icon: const Icon(Icons.format_list_bulleted_rounded)),
            ElevatedButton.icon(
                label: const Text('Forms OnBoarding Bank'),
                onPressed: () => Get.toNamed(Routes.formOnboardingBank),
                icon: const Icon(Icons.format_list_bulleted_rounded)),
            ElevatedButton.icon(
                label: const Text('Forms OnBoarding Domisili'),
                onPressed: () => Get.toNamed(Routes.formOnboardingDomisili),
                icon: const Icon(Icons.format_list_bulleted_rounded)),
            ElevatedButton.icon(
                label: const Text('Forms Login'),
                onPressed: () => Get.toNamed(Routes.formLogin),
                icon: const Icon(Icons.format_list_bulleted_rounded)),
          ].column().centered()));
}
