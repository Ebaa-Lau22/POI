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

  @override
  String get welcome => 'أهلاً بك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get enterValidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordValidation => 'ينبغي أن تتضمن كلمة المرور أحرفًا وأرقامًا، وألا يقل طولها عن 6 رموز';

  @override
  String get forgetPassword => 'هل نسيت كلمة المرور الخاصة بك ؟';

  @override
  String get signin => 'تسجيل الدخول';
}
