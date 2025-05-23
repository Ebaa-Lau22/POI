// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get helloWorld => 'مرحباً بالعالم';

  @override
  String get startCall => 'ابدأالاتصال';

  @override
  String get waitingForRemoteVideo => 'بانتظار الفيديو عن بعد';

  @override
  String get yourVideo => 'البث الخاص بك';
}
