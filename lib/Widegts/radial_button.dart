import 'dart:math';

import 'package:event_app/Utils/app_colors.dart';
import 'package:event_app/Utils/app_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Provider/data_class.dart';

class RadialMenu extends StatefulWidget {
  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(
      controller: controller,
    );
  }
}

class RadialAnimation extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotation;

  RadialAnimation({Key? key, required this.controller})
      : scale = Tween<double>(
          begin: 1.3,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
          ),
        ),
        translation = Tween<double>(
          begin: 0.0,
          end: 70.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        )),
        rotation = Tween<double>(
          begin: 0.0,
          end: 360.0,
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.7,
              curve: Curves.decelerate,
            ))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, builder) {
        return Transform.rotate(
          angle: radians(rotation.value),
          child: Container(
            height: 170,
            width: 200,
            child: Center(
              child: Stack(
                children: <Widget>[
                  _buildButton(180,
                      color: Colors.white,
                      icon: "assets/icons/Icon awesome-tasks.svg"),
                  _buildButton(240,
                      color: Colors.white, icon: "assets/icons/files-alt.svg"),
                  _buildButton(305,
                      color: Colors.white, icon: "assets/icons/video.svg"),
                  _buildButton(360,
                      color: Colors.white, icon: "assets/icons/camera.svg"),
                  Transform.scale(
                    scale: scale.value - 1.3,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      child: SvgPicture.asset("assets/icons/Cross.svg",
                          color: Colors.white, semanticsLabel: ''),
                      backgroundColor: kColorPrimary,
                      onPressed: _close,
                    ),
                  ),
                  Transform.scale(
                    scale: scale.value,
                    child: FloatingActionButton(
                      heroTag: "btn2",
                      child: SvgPicture.asset("assets/icons/plus.svg",
                          color: Colors.white, semanticsLabel: ''),
                      backgroundColor: kColorPrimary,
                      onPressed: _open,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildButton(double angle, {required Color color, required String icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            heroTag: null,
            child: SvgPicture.asset(icon,
                color: kColorPrimary, semanticsLabel: ''),
            backgroundColor: color,
            onPressed: () {
              //_close;
              print("I'm ");
            },
          ),
        ),
      ),
//       child: IconButton(
//         icon: Icon(Icons.access_alarm),
//         onPressed: () {
//           print('hello??11');
//         },
//       ),
    );
  }

  _open() {
    controller.forward();

    print("my name is open!");
  }

  _close() {
    controller.reverse();

    print("my name is closed");
  }

  double degrees2Radians = 3.1415 / 180.0;
  double radians(double degrees) => degrees * degrees2Radians;
}
