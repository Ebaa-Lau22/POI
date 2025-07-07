import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final double width;
  final double height;
  final Color firstColor;
  final Color secondColor;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final BorderRadiusGeometry borderRadius;
  final Widget child;

  const CustomGradientButton({
    Key? key,
    required this.width,
    required this.height,
    required this.firstColor,
    required this.secondColor,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
          begin: begin,
          end: end,
        ),
        borderRadius: borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
