import 'package:dartz/dartz.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/features/notifications/data/models/send_fcm_token_dto.dart';
import 'package:poi/features/notifications/data/resources/notifications_remote_data_source.dart';
import 'package:poi/features/notifications/domain/repo/notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsRemoteDataSource _notificationsRemoteDataSource;
  NotificationsRepoImpl(this._notificationsRemoteDataSource);

  @override
  Future<Either<Failure, Unit>> sendFcmToken(SendFcmTokenDto request) async {
    try {
      await _notificationsRemoteDataSource.sendFcmToken(request);
      return Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
