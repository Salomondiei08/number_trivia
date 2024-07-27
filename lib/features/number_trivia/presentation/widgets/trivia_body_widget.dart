import 'package:flutter/material.dart';

class TriviaBodyWidget extends StatelessWidget {
  const TriviaBodyWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 2, child: Center(child: child));
  }
}