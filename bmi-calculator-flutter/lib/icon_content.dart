import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

class IconWidget extends StatelessWidget {
  final IconData iconData;
  final String title;

  IconWidget({this.iconData, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          iconData,
          size: 80,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
            title,
            style: kLabelTextStyle
        ),
      ],
    );
  }
}