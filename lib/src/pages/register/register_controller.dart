import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_app_delivery/src/models/response_api.dart';
import 'package:flutter_app_delivery/src/models/user.dart';
import 'package:flutter_app_delivery/src/pages/home/home_page.dart';
import 'package:flutter_app_delivery/src/pages/login/login_page.dart';
import 'package:flutter_app_delivery/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

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
  static const home = "/home";

  /* Future<void> register() async {
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

      final url = Uri.parse(
          'http://192.168.1.9:3000/api/users/createWithImage'); // Cambia esto por la URL de tu backend
      final request = http.MultipartRequest('POST', url);
      request.fields.addAll({
        'user': json.encode(user.toJson()),
      });
      if (imageFile != null) {
        final fileStream = http.ByteStream(imageFile!.openRead());
        final fileLength = await imageFile!.length();
        final fileName = imageFile!.path.split('/').last;
        final multipartFile = http.MultipartFile(
          'image',
          fileStream,
          fileLength,
          filename: fileName,
        );
        request.files.add(multipartFile);
      }

      try {
        final response = await request.send();
        final responseString = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseString);
        if (response.statusCode == 201 && jsonResponse['success'] == true) {
          GetStorage().write('user', jsonResponse['data']);
          goToHomePage();
        } else {
          Get.snackbar('Registro fallido', jsonResponse['message'] ?? '');
        }
      } catch (e) {
        print(e);
        Get.snackbar(
            'Registro fallido', 'Hubo un error con el registro del usuario');
      }
    }
  } */

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {

    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(max: 100, msg: 'Registrando datos...');

      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      Stream stream = await usersProvider.createWithImageUser(user, imageFile!);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        try {
          if (responseApi.success == true) {
            GetStorage()
                .write('user', responseApi.data); // DATOS DEL USUARIO EN SESION
            goToHomePage();
            //Get.toNamed('/home');
            //Get.to(() => HomePage());
          } else {
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }
        } catch (e) {
          print(e);
        }
      });
    }
  }

  void goToHomePage() {
    //Get.offNamedUntil('/home', (route) => false);
    Get.offNamedUntil('/home', (route) => false);
    /* Get.to(
      () => HomePage(),
    ); */
  }

  bool isValidForm(
    String email,
    String name,
    String lastname,
    String phone,
    String password,
    String confirmPassword,
  ) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu apellido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar(
          'Formulario no valido', 'Debes ingresar tu numero telefonico');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no valido',
          'Debes ingresar la confirmacion del password');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulario no valido', 'los password no coinciden');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar(
          'Formulario no valido', 'Debes seleccionar una imagen de perfil');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
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
          style: TextStyle(color: Colors.black),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'CAMARA',
          style: TextStyle(color: Colors.black),
        ));

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
