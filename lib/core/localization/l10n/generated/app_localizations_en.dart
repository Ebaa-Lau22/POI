// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get startCall => 'Start Call';

  @override
  String get waitingForRemoteVideo => 'Waiting for Remote Video';

  @override
  String get yourVideo => 'Your Video Preview';

  @override
  String get random => 'Random';

  @override
  String get excellent => 'Excellent';

  @override
  String get good => 'Good';

  @override
  String get poor => 'Poor';

  @override
  String get unknown => 'No Connection';
}
