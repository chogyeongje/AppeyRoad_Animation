import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubPage extends StatefulWidget {
  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  Color currentColor = Colors.blue;
  var height = 150;
  var width = 150;
  var borderRadius = 10;
  var alignment = Alignment.center;
  var icon = Icons.home;
  var backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    for (int i = 0; i < 100; i++) {
      await Future.delayed(Duration(seconds: 1));
      _randomizeParameters();
    }
  }

  _randomizeParameters() {
    setState(() {
      height = Random().nextInt(100) + 80;
      width = Random().nextInt(100) + 80;
      var randomIndex = Random().nextInt(colors.length);
      currentColor = colors[randomIndex];
      backgroundColor = backgroundColors[randomIndex];
      borderRadius = Random().nextInt(50) + 5;
      var currentAlignment = Random().nextInt(alignments.length);
      alignment = alignments[currentAlignment];
      var iconsIndex = Random().nextInt(icons.length);
      icon = icons[iconsIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _init,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 700),
        alignment: alignment,
        color: backgroundColor,
        child: AnimatedPadding(
          duration: Duration(milliseconds: 700),
          padding: EdgeInsets.all(
              height > width ? height.toDouble() : width.toDouble()),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 700),
            height: height.toDouble(),
            width: width.toDouble(),
            alignment: alignment,
            curve: Curves.easeInCubic,
            padding: EdgeInsets.all(height > width ? width / 10 : height / 10),
            transform: Matrix4.rotationZ(height.toDouble() / 30),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 30,
              ),
            ),
            decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(borderRadius.toDouble())),
          ),
        ),
      ),
    );
  }
}

var colors = [
  Colors.blue,
  Colors.red,
  Colors.pink,
  Colors.green,
  Colors.yellow,
  Colors.black,
  Colors.indigo
];

var backgroundColors = [
  Colors.white,
  Colors.black12,
  Colors.grey,
  Colors.cyanAccent,
  Colors.lightBlueAccent,
  Colors.purpleAccent,
  Colors.yellowAccent
];

var icons = [
  Icons.map,
  Icons.add,
  Icons.home,
  Icons.person_outline,
  Icons.extension,
  Icons.ac_unit,
  Icons.add_a_photo
];

var alignments = [
  Alignment.center,
  Alignment.centerLeft,
  Alignment.centerRight,
  Alignment.bottomCenter,
  Alignment.bottomLeft,
  Alignment.bottomRight,
  Alignment.topCenter,
  Alignment.topRight,
  Alignment.topLeft,
];
