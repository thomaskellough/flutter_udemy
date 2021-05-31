import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text('Ask Me Anything'),
          backgroundColor: Colors.blue[900],
        ),
        body: BallPage(),
      ),
    ),
  );
}

class BallPage extends StatefulWidget {
  const BallPage({Key key}) : super(key: key);

  @override
  _BallPageState createState() => _BallPageState();
}

class _BallPageState extends State<BallPage> {
  final List<Color> colorList = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.orange];
  int ballOption = 1;
  Color selectedColor = Colors.blue;

  shakeBall() {
    setState(() {
      ballOption = Random().nextInt(5) + 1;
      selectedColor = colorList[Random().nextInt(colorList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: selectedColor,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      child: Center(
        child: FlatButton(
          onPressed: () {
            shakeBall();
          },
          child: Image.asset('images/ball$ballOption.png'),
        ),
      ),
    );
  }
}
