import 'package:flutter/material.dart';

class CustomSpeakingIndicator extends StatelessWidget {
  final bool isSpeaking;
  final Color activeColor;
  final Color inactiveColor;

  const CustomSpeakingIndicator({
    super.key,
    required this.isSpeaking,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 270),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: isSpeaking ? activeColor : Colors.transparent,
          width: 2.8,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSpeaking ? activeColor : inactiveColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.mic,
          color: isSpeaking ? activeColor : inactiveColor,
          size: 20,
        ),
      ),
    );
  }
}
