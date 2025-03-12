import 'package:flutter/material.dart';

class AnimatedCategoryItem extends StatelessWidget {
  AnimatedCategoryItem({
    super.key,
    required double startDelayFraction,
    required this.controller,
    required this.child,
  }) : topPaddingAnimation = Tween(
          begin: 0.0,
          end: 16.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000 + startDelayFraction,
              0.400 + startDelayFraction,
              curve: Curves.ease,
            ),
          ),
        );

  final Widget child;
  final AnimationController controller;
  final Animation<double> topPaddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(top: topPaddingAnimation.value),
          child: child,
        );
      },
      child: child,
    );
  }
}
