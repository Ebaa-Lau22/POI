import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    enabled: true,
    useHistory: true,
    maxHistoryItems: 100,
    useConsoleLogs: true,
    timeFormat: TimeFormat.yearMonthDayAndTime,
    colors: {
      TalkerLogType.httpResponse.key: AnsiPen()..green(bold: true),
      TalkerLogType.httpRequest.key: AnsiPen()..yellow(bold: true),
      TalkerLogType.httpError.key: AnsiPen()..red(bold: true),
      TalkerLogType.blocClose.key: AnsiPen()..magenta(bold: true),
      TalkerLogType.blocCreate.key: AnsiPen()..xterm(50),
      TalkerLogType.blocTransition.key: AnsiPen()..yellow(bold: true),
      TalkerLogType.info.key: AnsiPen()..green(bold: true),
    },
    titles: {
      TalkerLogType.httpResponse.key: "Response",
      TalkerLogType.httpRequest.key: "Request",
      TalkerLogType.httpError.key: "Error",
      TalkerLogType.blocClose.key: "Bloc Close",
      TalkerLogType.blocCreate.key: "Bloc Create",
      TalkerLogType.blocTransition.key: "Bloc Transition",
      TalkerLogType.route.key: "Navigation",
      TalkerLogType.info.key: "Info",
    },
  ),
);

class Dev {
  Dev._();
  static void logValue(dynamic value) {
    talker.info("The value is : ******  $value  ******");
  }

  static void logError(dynamic value) {
    talker.error(value);
  }

  static void logLine(dynamic value) {
    talker.info(value);
  }

  static void logSuccess(dynamic value) {
    talker.info(value);
  }

  static void logList(List items) {
    talker.info("List size is ${items.length}");
    for (int i = 0; i < items.length; i++) {
      talker.info("Item with index $i ===> ${items[i]}");
    }
  }

  static void logLineWithTag({dynamic tag, dynamic message}) {
    talker.verbose('$tag : $message');
  }

  static void logLineWithTagError({
    dynamic tag,
    dynamic message,
    dynamic error,
  }) {
    talker.error('$tag: $message >>>>> Error => $error');
  }

  static void logDivider({dynamic symbole = '*', dynamic lenght = 50}) {
    talker.info("$symbole" * lenght);
  }

  static void logWithLine({dynamic title}) {
    logDivider();
    talker.info(title);
    logDivider();
  }
}
