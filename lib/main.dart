import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_assistant/services/preferences.dart';
import 'package:patient_assistant/theme.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constant.dart';
import 'routes/app_pages.dart';
import 'controllers/app_controller.dart';
import 'controllers/auth_controller.dart';
import 'database/firebase.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:  kPrimaryColor,
        systemNavigationBarColor: kPrimaryColor,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
          systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: kPrimaryColor,

      ));
      await Firebase.initializeApp();
      await initDependencies();
  runApp(MyApp());
}
Future<void> initDependencies()async{
  Get.put<AppController>(AppController());
  Get.put<CloudDatabase>(CloudDatabase());
  await Get.putAsync(() => Preferences().init());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medical Assistant',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      initialRoute: AppPages.initial,
      getPages:AppPages.routes,
    );
  }
}
