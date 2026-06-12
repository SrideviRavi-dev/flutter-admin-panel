import 'package:admin/bindings/general_bindings/general_bindings.dart';
import 'package:admin/routes/app_routes.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AdminPanel',
      themeMode: ThemeMode.light,
      theme: JAppTheme.lightTheme,
      darkTheme: JAppTheme.darkTheme,
      initialRoute: JRoutes.dashboard,
      getPages: JAppRoute.pages,
      initialBinding: GeneralBindings(),
      unknownRoute: GetPage(name: '/Page-not-found', page: ()=> const Scaffold(body:Center(child: Text('Page Not Found')))),
    );
  }
}
