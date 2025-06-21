import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Custom scroll physics to instantly snap pages without animation
class InstantSnapScrollPhysics extends PageScrollPhysics {
  const InstantSnapScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  InstantSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return InstantSnapScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position,
      double velocity,
      ) {
    // Decide new page from PageScrollPhysics
    final Simulation? springSim = super.createBallisticSimulation(position, velocity);
    if (springSim != null && springSim is ScrollSpringSimulation) {
      final double targetPixels = springSim.x(double.infinity);

      // Immediately jump to target world position
      return ClampingScrollSimulation(
        position: targetPixels,
        velocity: 0,
        tolerance: tolerance,
      );
    }
    return null;
  }
}