import 'package:flutter/material.dart';
import 'constants.dart';

class ContainerButton extends StatelessWidget {
  String text;

  ContainerButton({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        bottom: 20.0,
      ),
      child: Text(
        text,
        style: kLargeButtonTextStyle,
      ),
      color: kBottomBarColor,
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: kBottomContainerHeight,
    );
  }
}