import 'dart:async';

class NotificationCompleter {
  late Completer<bool> completer;
  bool _openedFromNotification = false;
  bool _shouldRefresh = false;
  NotificationCompleter() {
    completer = Completer<bool>();
  }
  void success() {
    if (!completer.isCompleted) {
      completer.complete(true);
    }
  }

  void setOpenedFromNotification(bool value) {
    _openedFromNotification = value;
  }

  bool get openedFromNotification => _openedFromNotification;
  void setShouldRefresh(bool value) {
    _shouldRefresh = value;
  }

  bool get shouldRefreshNotification => _shouldRefresh;
}
