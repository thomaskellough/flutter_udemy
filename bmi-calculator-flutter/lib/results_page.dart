import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/container_button.dart';
import 'package:bmi_calculator/reusable_container.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  String title;
  String bmi;
  String message;

  ResultsPage({@required this.title, @required this.bmi, @required this.message});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    title = arguments["resultTitle"];
    bmi = arguments["bmiResult"];
    message = arguments["resultInterpretation"];

    return Scaffold(
        appBar: AppBar(
          title: Text("BMI CALCULATOR"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Your result',
              style: kTitleTextStyle,
            ),
            Expanded(
              child: ReusableContainer(
                color: kActiveCardColor,
                cardChild: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: kColoredTitleTextStyle,
                      ),
                      Text(
                        bmi,
                        style: kNumberTextStyle,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: kBodyTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ContainerButton(
              text: 'Re-calculate',
            ),
          ],
        ));
  }
  
}
