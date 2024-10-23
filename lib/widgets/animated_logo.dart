import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      curve: Curves.easeInOut,
      width: 100, // Adjust width as needed
      height: 100, // Adjust height as needed
      child: FlutterLogo(),
    );
  }
}
