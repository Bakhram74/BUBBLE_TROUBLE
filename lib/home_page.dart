import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juse/boll.dart';
import 'package:juse/button.dart';
import 'package:juse/missle.dart';
import 'package:juse/palyer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double playerX = 0;
  double missleX = playerX;
  double missleHeight = 10;
  double bollX = 0.5;

  double bollY = 0;
  bool midShot = false;
  Direction bollDirection = Direction.LEFT;

  void startGame() {
    double time = 0;
    double height = 0;
    double velosity = 60;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      height = -5 * time * time + velosity * time;
      if (height < 0) {
        time = 0;
      }
      setState(() {
        bollY = heightToPosition(height);
      });
      time += 0.1;
      if (bollX - 0.005 < -1) {
        bollDirection = Direction.RIGHT;
      } else if (bollX + 0.005 > 1) {
        bollDirection = Direction.LEFT;
      }
      if (bollDirection == Direction.RIGHT) {
        setState(() {
          bollX += 0.03;
        });
      } else if (bollDirection == Direction.LEFT) {
        setState(() {
          bollX -= 0.03;
        });
      }
    });
  }

  double heightToPosition(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double missileY = 1 - 2 * height / totalHeight;
    return missileY;
  }

  void resetMissle() {
    missleX = playerX;
    midShot = false;
    missleHeight = 10;
  }

  void fireMissle() {
    if (midShot == false) {
      Timer.periodic(Duration(milliseconds: 5), (time) {
        midShot = true;
        setState(() {
          missleHeight += 10;
        });
        if (missleHeight > MediaQuery.of(context).size.height * 3 / 4) {
          time.cancel();
          resetMissle();
        }

        if (bollY > heightToPosition(missleHeight) &&
            (bollX - missleX).abs() < 0.03) {
          resetMissle();
          time.cancel();
          setState(() {
            bollX = 5;
          });
        }
      });
    }
  }

  void moveLeft() {
    setState(() {
      if (playerX > -1) {
        playerX -= 0.1;
        missleX = playerX;
      }
      if (!midShot) {
        missleX != playerX;
      }
    });
  }

  void moveRight() {
    missleX = playerX;
    setState(() {
      if (playerX < 1) {
        playerX += 0.1;
        missleX = playerX;
      }
      if (!midShot) {
        missleX != playerX;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          fireMissle();
        }
      },
      child: Column(children: [
        Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink.shade200,
              child: Center(
                child: Stack(
                  children: [
                    MyBoll(
                      bollX: bollX,
                      bollY: bollY,
                    ),
                    Missle(
                      height: missleHeight,
                      missleX: missleX,
                    ),
                    MyPlayer(
                      playerX: playerX,
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
            child: Container(
          color: Colors.grey,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            MyButton(
              icon: Icons.play_arrow,
              function: startGame,
            ),
            MyButton(
              icon: Icons.arrow_back,
              function: moveLeft,
            ),
            MyButton(
              icon: Icons.arrow_upward,
              function: fireMissle,
            ),
            MyButton(
              icon: Icons.arrow_forward,
              function: moveRight,
            ),
          ]),
        )),
      ]),
    );
  }
}
