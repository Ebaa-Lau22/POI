import 'package:dartz/dartz.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/notifications/data/models/send_fcm_token_dto.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, Unit>> sendFcmToken(SendFcmTokenDto request);
}
