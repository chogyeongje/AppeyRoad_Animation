import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math';
import 'sub.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MainPage(),
      home: SubPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool isChecked = false;
  Rect rect;

  // ignore: deprecated_member_use
  var tween = MultiTrackTween([

    Track('rotation').add(Duration(seconds: 1), Tween(begin: -2 * pi, end: 0.0)),
    Track('color').add(Duration(seconds: 1), ColorTween(begin: Colors.white, end: Colors.black)),

    Track('size_sun').add(Duration(seconds: 1), Tween(begin: 0.0, end: 200.0), curve: Interval(0.5, 1.0)),
    Track('size_cloud').add(Duration(seconds: 1), Tween(begin: 200.0, end: 0.0), curve: Interval(0.0, 0.5)),

    Track('paddingLeft').add(Duration(seconds: 1), Tween(begin: 0.0, end: 50.0)),
    Track('back_color').add(Duration(seconds: 1), ColorTween(begin: Colors.black, end: Colors.white)),

    Track('opacity').add(Duration(seconds: 1), Tween(begin: 1.0, end: 0.0)),
  ]);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    rect = isChecked ? Rect.fromCenter(center: Offset(width / 2, height / 2), width: 0.0, height: 0.0)
        : Rect.fromCenter(center: Offset(width / 2, height / 2), width: height*2.6, height: height*2.6);

    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        // ignore: deprecated_member_use
        child: ControlledAnimation(
          playback: isChecked ? Playback.PLAY_FORWARD : Playback.PLAY_REVERSE,
          startPosition: isChecked ? 1.0 : 0.0,
          tween: tween,
          duration: tween.duration,
          curve: Curves.easeInOut,
          builder: (context, animation){
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  // (1)
                  curve: isChecked ? Interval(0.0, 0.5) : Interval(0.5, 1.0),
                  // (2)
                  left: rect.left,
                  right: width - rect.right,
                  top: rect.top,
                  bottom: height - rect.bottom,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Transform.rotate(
                    angle: animation['rotation'],
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(Icons.wb_cloudy, size: animation['size_sun'], color: animation['color'],),
                      Icon(Icons.wb_sunny, size: animation['size_cloud'], color: animation['color'],)
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 500,
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.grey,
                        ),
                        height: 50,
                        width: 100,
                        padding: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: animation['paddingLeft']),
                          child: Transform.rotate(
                              angle: animation['rotation'],
                            child: Container(
                              decoration: BoxDecoration(
                                // (3)
                                shape: BoxShape.circle,
                                color: animation['back_color'],
                              ),
                              height: 40.0,
                              width: 40.0,
                                child: Stack(
                                  children: <Widget>[
                                    Opacity(
                                      child: Icon(Icons.wb_cloudy, color: animation['color'],),
                                      opacity: 1.0 - animation['opacity'],
                                    ),
                                    Opacity(
                                      child: Icon(Icons.wb_sunny, color: animation['color'],),
                                      opacity: animation['opacity'],
                                    ),
                                  ],
                                  alignment: Alignment.center,
                                ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),

      ),
    );
  }
}
