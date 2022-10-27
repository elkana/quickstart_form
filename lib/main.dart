import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quickstart_form/pages/forms/onboarding/form_onboarding_bank_view.dart';
import 'package:quickstart_form/pages/forms/onboarding/form_onboarding_domisili_view.dart';
import 'package:quickstart_form/pages/forms/onboarding/form_onboarding_job_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'configs/locales.dart';
import 'pages/forms/login/login_view.dart';
import 'pages/forms/login/reset_pwd/resetpwd_view.dart';
import 'pages/forms/login/signup/signup_view.dart';
import 'pages/forms/onboarding/form_onboarding_personal_view.dart';
import 'pages/forms/sample/form_sample_view.dart';
import 'pages/home/home_view.dart';
import 'routes/app_routes.dart';
import 'utils/hive_util.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
      initialRoute: Routes.home,
      onInit: () async {
        await HiveUtil.registerAdaptersFirstTime();
        await GetStorage.init();
      },
      theme: ThemeData.dark(),
      locale: const Locale('en', 'US'),
      // what is this ?
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
      translationsKeys: AppTranslation.translations,
      getPages: [
        GetPage(name: Routes.home, page: () => const HomeView(), binding: HomeBinding()),
        GetPage(name: Routes.formLogin, page: () => const LoginView(), binding: LoginBinding()),
        GetPage(name: Routes.formResetPwd, page: () => const ResetPwdView(), binding: ResetPwdBinding()),
        GetPage(name: Routes.formSignUp, page: () => const SignUpView(), binding: SignUpBinding()),
        GetPage(name: Routes.formSample, page: () => const FormSampleView(), binding: FormSampleBinding()),
        GetPage(
            name: Routes.formOnboardingPersonal,
            page: () => const FormOnBoardingPersonalView(),
            binding: FormOnBoardingPersonalBinding()),
        GetPage(
            name: Routes.formOnboardingJob,
            page: () => const FormOnBoardingJobView(),
            binding: FormOnBoardingJobBinding()),
        GetPage(
            name: Routes.formOnboardingBank,
            page: () => const FormOnBoardingBankView(),
            binding: FormOnBoardingBankBinding()),
        GetPage(
            name: Routes.formOnboardingDomisili,
            page: () => const FormOnBoardingDomisiliView(),
            binding: FormOnBoardingDomisiliBinding()),
      ]);
}
