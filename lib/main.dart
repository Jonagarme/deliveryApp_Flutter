import 'package:flutter/material.dart';
import 'package:flutter_app_delivery/src/pages/home/home_page.dart';
import 'package:flutter_app_delivery/src/pages/login/login_page.dart';
import 'package:flutter_app_delivery/src/pages/register/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery Udemy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          onBackground: Colors.grey,
          secondary: Colors.amberAccent,
          primary: Colors.amber,
          onPrimary: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          onSecondary: Colors.grey,
          background: Colors.grey,
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
