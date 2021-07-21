import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SpinKitDualRing(
        color: kPrimaryColorLight,
        size: 50,
      ),
    );
  }
}
