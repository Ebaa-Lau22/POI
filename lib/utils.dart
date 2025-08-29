import 'dart:async';

import 'package:poi/core/storage/preferences_database.dart';

FutureOr<void> Function()? onWindowShouldClose;
final prefs = PreferencesDatabase();

Future<String?> checkIfTokenExist() async {
  final savedToken = await prefs.getToken();
  if (savedToken == null) {
    throw Exception("No token found in secure storage.");
  }
  return savedToken;
}
