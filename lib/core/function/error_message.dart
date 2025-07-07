import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/error/failures.dart';

String mapFailureToMessage(Failure failure) {
  print("Failure is: ${failure.runtimeType}");
  if (failure is WrongDataFailure) {
    return incorrect_Data_Failure_Message;
  } else if (failure is EmptyCacheFailure) {
    return EMPTY_CACHE_FAILURE_MESSAGE;
  } else if (failure is ServerFailure) {
    return SERVER_FAILURE_MESSAGE;
  } else if (failure is OfflineFailure) {
    return OFFLINE_FAILURE_MESSAGE;
  } else {
    return UNEXPECTED_FAILURE_MESSAGE;
  }
}
