import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class TransitionsAnimation {
  static void moveToNextPage(BuildContext context, {required Widget route}) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
        child: route,
      ),
    );
  }

  static void moveToNextPageWithDowntoUp(
    BuildContext context, {
    required Widget route,
  }) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 300),
        child: route,
      ),
    );
  }

  static void moveToNextPageWithReplacement(
    BuildContext context, {
    required Widget route,
  }) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 500),
        child: route,
      ),
    );
  }
}
