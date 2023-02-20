import 'package:flutter/material.dart';
import 'package:flutter_app_delivery/src/models/response_api.dart';
import 'package:flutter_app_delivery/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response API ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage()
            .write('user', responseApi.data); //almacenando los datos de sesion
        goToHomePage();
      } else {
        Get.snackbar('Login Fallido', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Email');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Password');
      return false;
    }
    return true;
  }
}
