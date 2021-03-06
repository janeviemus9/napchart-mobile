import 'package:flutter/material.dart';
import 'dart:math';

class Utils {
  // Given an Offset centerPoint double radius, int minutes,
  // return an x,y of the point on the canvas.
  static Offset getCoord(Offset centerPoint, double radius, int minutes,
      double startPointRadians) {
    const MINUTES_PER_DAY = 1440;
    var startTimeRadians =
        startPointRadians - ((minutes / MINUTES_PER_DAY) * 2 * pi);
    return Offset(centerPoint.dx + cos(startTimeRadians) * radius,
        centerPoint.dy - sin(startTimeRadians) * radius);
  }

  static Offset getCoordFromPolar(
      Offset centerPoint, double radius, double angle, double startRadians) {
    return Offset(centerPoint.dx + (cos(angle + startRadians) * radius),
        centerPoint.dy - (sin(angle + startRadians) * radius));
  }

  static T tryCast<T>(x) {
    return x is T ? x : null;
  }
}
