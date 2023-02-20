import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_delivery/src/models/user.dart';
import 'package:flutter_app_delivery/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      Response response = await usersProvider.create(user);

      print('Response: ${response.body}');

      Get.snackbar(
          'Formulario valido', 'Estas listo para enviar la peticion http');
    }
  }

  bool isValidForm(String email, String name, String lastname, String phone,
      String confirmPassword, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Email');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Nombre');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes ingresar tu numero telefonico');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Password');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido',
          'Debes ingresar la confirmacion del password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'Las contraseñan no coinciden');
      return false;
    }
    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(
      source: imageSource,
    );
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: Text(
        'GALERIA',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      child: Text(
        'CAMARA',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
