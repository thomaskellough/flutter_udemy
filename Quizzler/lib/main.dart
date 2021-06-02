import 'dart:io';
import 'package:Quizzler/QuizBrain.dart';
import 'package:Quizzler/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: Text(
            'Quizzler',
          ),
        ),
        body: QuizzPage(),
      ),
    );
  }
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key key}) : super(key: key);

  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<Icon> scoreKeeperList = [];
  int currentQuestion = 0;
  int score = 0;

  void updateScore(answer) {
    setState(() {
      if (answer == quizBrain.getAnswer(currentQuestion)) {
        score++;
        scoreKeeperList.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeperList.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      if (!quizBrain.hasNextQuestion(currentQuestion)) {
        currentQuestion = 0;
        scoreKeeperList.clear();
        AwesomeDialog(
          context: context,
          title: 'Game over!',
          desc: 'You scored $score',
          dialogType: DialogType.SUCCES,
          btnOkText: 'Play again?',
          btnOkOnPress: () {},
          showCloseIcon: true,
          animType: AnimType.SCALE,
        )..show();
      } else {
        currentQuestion += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    quizBrain.getQuestion(currentQuestion),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pacifico(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  // TypewriterAnimatedTextKit(
                  //   text: [questions[currentQuestion]],
                  //   textAlign: TextAlign.center,
                  //   textStyle: GoogleFonts.pacifico(
                  //     fontStyle: FontStyle.normal,
                  //     color: Colors.white,
                  //     fontSize: 28,
                  //   ),
                  //   isRepeatingAnimation: false,
                  //   duration: Duration(seconds: 2),
                  //   ),
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: CupertinoButton(
              color: Colors.green,
              child: Text('True'),
              onPressed: () {
                updateScore(true);
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: CupertinoButton(
              color: Colors.red,
              child: Text('False'),
              onPressed: () {
                updateScore(false);
              },
            ),
          ),
          Row(
            children: scoreKeeperList,
          ),
        ],
      ),
    );
  }
}
