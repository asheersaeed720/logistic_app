import 'package:flutter/material.dart';

import 'package:hani_almutairi_logistic/utils/theme.dart';

class HeadingTitle extends StatelessWidget {
  final headingTitle;

  HeadingTitle(this.headingTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      width: MediaQuery.of(context).size.width / 1,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        gradient: new LinearGradient(
          colors: [
            CustomColor.gradientEnd,
            CustomColor.gradientStart,
          ],
          begin: const FractionalOffset(0.2, 0.2),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          headingTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.5,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
