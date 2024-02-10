import 'package:flutter/material.dart';

class MyBoll extends StatelessWidget {
  final  double bollX;
final  double bollY;
  const MyBoll({super.key,required this.bollX,required this.bollY});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment(bollX,bollY),
      child: Container(
        width: 10,
        height: 10,
        decoration:const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.brown,
      
        ),
      ),
    );
  }
}