import 'package:flutter/material.dart';
import 'package:poi/features/Authentication/presentation/pages/Login_page.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) => false,
);

void navigateAndPopAll(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
  (route) => false,
);

void navigateToLoginAndClear(context) {
  // Clear the entire navigation stack and push LoginPage as the only route
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
    (route) => false,
  );
}
