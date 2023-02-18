import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  const LoginPage ({Key? Key}) : super(key: Key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          _imageCover()
        ],
      )
    );
  }

  Widget _imageCover(){
    return Container(
      child: Image.asset(
        'assets/img/delivery.png',
        width: 130,
        height: 130,
      ),
    );
  }

}
