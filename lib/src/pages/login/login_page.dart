import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? Key}) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      body: Stack(
        //POSICIONAR ELEMENTOS UNO DE ENCIMA  DEL OTRO
        children: [
          _backgroundCover(context),
          Column(
            //POSICIONAR ELEMENTOS UNO DE ABAJO DEL OTRO (VERTICAL)
            children: [
              _imageCover(),
              _textAppName(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.amber,
    );
  }

  Widget _textAppName() {
    return Text(
      'DELIVERY MSQYL',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      //UBICAR ELEMENTOS UNO A LADO DEL OTRO (HORIZONTAL)
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No tienes cuenta?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          'Registrate Aqui',
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.topCenter,
        child: Image.asset(
          'assets/img/delivery.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}
