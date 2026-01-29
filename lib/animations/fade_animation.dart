import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value as double,
        child: Transform.translate(
            offset: Offset(0, (1 - (value as double)) * -30), child: child),
      ),
    );
  }
}
