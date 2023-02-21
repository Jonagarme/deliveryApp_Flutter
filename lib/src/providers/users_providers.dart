import 'dart:convert';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter_app_delivery/src/env/enviroment.dart';
import 'package:flutter_app_delivery/src/models/response_api.dart';
import 'package:flutter_app_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect {
  String url = Enviroment.API_URL + 'api/users';

  Future<Response> create(User user) async {
    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {'Content-Type': 'application/json'},
    ); //esperar hasta que el servidor retorno la respuesta
    return response;
  }

  Future<Stream> createWithImageUser(User user, File image) async {
    Uri uri = Uri.http(Enviroment.API_URL_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      http.MultipartFile(
        'image',
        http.ByteStream(
          image.openRead().cast(),
        ),
        await image.length(),
        filename: basename(image.path),
      ),
    );
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /* Future<ResponseApi> createUserWithImage(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);

    if(response.body == null){
      Get.snackbar('Erro en la peticion', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }*/

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
      '$url/login',
      {
        'email': email,
        'password': password,
      },
      headers: {'Content-Type': 'application/json'},
    ); //esperar hasta que el servidor retorno la respuesta
    if (response.body == null) {
      Get.snackbar('ERROR', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
