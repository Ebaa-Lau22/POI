import 'package:dartz/dartz.dart';
import 'package:poi/features/notifications/data/models/send_fcm_token_dto.dart';
import 'package:poi/features/notifications/domain/repo/notifications_repo.dart';
import '../../../../core/error/failures.dart';

class SendFcmTokenUseCase {
  final NotificationsRepo _repo;

  SendFcmTokenUseCase(this._repo);

  Future<Either<Failure, Unit>> call({required SendFcmTokenDto request}) async {
    return await _repo.sendFcmToken(request);
  }
}
