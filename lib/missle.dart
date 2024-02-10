import 'package:flutter/material.dart';


class Missle extends StatelessWidget {
  final double height;
  final double missleX;
  const Missle({super.key, required this.height, required this.missleX});

  @override
  Widget build(BuildContext context) {
    return Container(
                      alignment: Alignment(missleX, 1),
                      child: Container(
                        color: Colors.green,
                        width: 2,
                        height: height,
                      ),
                    );
  }
}