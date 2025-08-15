import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @startCall.
  ///
  /// In en, this message translates to:
  /// **'Start Call'**
  String get startCall;

  /// No description provided for @waitingForRemoteVideo.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Remote Video'**
  String get waitingForRemoteVideo;

  /// No description provided for @yourVideo.
  ///
  /// In en, this message translates to:
  /// **'Your Video Preview'**
  String get yourVideo;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get enterValidEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordValidationMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain both letters and numbers and be at least 8 characters long'**
  String get passwordValidationMessage;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget your password?'**
  String get forgetPassword;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signin;

  /// No description provided for @random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get excellent;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get poor;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'No Connection'**
  String get unknown;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @assign_debate_sides.
  ///
  /// In en, this message translates to:
  /// **'Assign Debate Sides'**
  String get assign_debate_sides;

  /// No description provided for @select_debate_motion.
  ///
  /// In en, this message translates to:
  /// **'Select Debate Motion'**
  String get select_debate_motion;

  /// No description provided for @search_motion.
  ///
  /// In en, this message translates to:
  /// **'Search Motion'**
  String get search_motion;

  /// No description provided for @motion.
  ///
  /// In en, this message translates to:
  /// **'The Motion'**
  String get motion;

  /// No description provided for @select_new_motion.
  ///
  /// In en, this message translates to:
  /// **'Select New Motion'**
  String get select_new_motion;

  /// No description provided for @select_topics.
  ///
  /// In en, this message translates to:
  /// **'Select the motion topics (2 maximum)'**
  String get select_topics;

  /// No description provided for @filter_motion.
  ///
  /// In en, this message translates to:
  /// **'Filter Motions'**
  String get filter_motion;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @forgetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgetYourPassword;

  /// No description provided for @enterEmailToGetCode.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to receive a verification code for password reset.'**
  String get enterEmailToGetCode;

  /// No description provided for @yourEmail.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get yourEmail;

  /// No description provided for @sendResetCode.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendResetCode;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code'**
  String get enterCode;

  /// No description provided for @enterCodeDescripe.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code sent to your email.'**
  String get enterCodeDescripe;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @confirmCode.
  ///
  /// In en, this message translates to:
  /// **'Confirm Code'**
  String get confirmCode;

  /// No description provided for @notRecieveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? Resend'**
  String get notRecieveCode;

  /// No description provided for @enterCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code'**
  String get enterCodeValidation;

  /// No description provided for @codeValidation.
  ///
  /// In en, this message translates to:
  /// **'The code must be 6 digits'**
  String get codeValidation;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Verification code has been resent'**
  String get codeResent;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @passNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passNotMatch;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @serverFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Please try again later .'**
  String get serverFailureMessage;

  /// No description provided for @emptyCacheFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get emptyCacheFailureMessage;

  /// No description provided for @offlineFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Please Check your Internet Connection'**
  String get offlineFailureMessage;

  /// No description provided for @unexpectedFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'Unexpected Failure'**
  String get unexpectedFailureMessage;

  /// No description provided for @incorrectDataFailureMessage.
  ///
  /// In en, this message translates to:
  /// **'The provided information is not correct. Please try again.'**
  String get incorrectDataFailureMessage;

  /// No description provided for @debates.
  ///
  /// In en, this message translates to:
  /// **'Debates'**
  String get debates;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @archived.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get archived;

  /// No description provided for @userType.
  ///
  /// In en, this message translates to:
  /// **'User Type'**
  String get userType;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @governorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get governorate;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @educationDegree.
  ///
  /// In en, this message translates to:
  /// **'Education Degree'**
  String get educationDegree;

  /// No description provided for @faculty.
  ///
  /// In en, this message translates to:
  /// **'Faculty'**
  String get faculty;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @confirmLogoutText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get confirmLogoutText;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
