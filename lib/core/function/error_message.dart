import 'package:poi/core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure _:
      return 'حدث خطأ ما أثناء جلب المعلومات';
    case EmptyCacheFailure _:
      return 'EMPTY_CACHE_FAILURE_MESSAGE';
    case OfflineFailure _:
      return 'خطأ في الاتصال بالانترنت ';
    default:
      return "خطأ غير متوقع أعد المحاولة لا حقاً";
  }
}
