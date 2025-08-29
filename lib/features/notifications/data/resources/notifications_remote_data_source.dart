import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/error/exceptions.dart';

import 'package:poi/features/notifications/data/models/send_fcm_token_dto.dart';
import 'package:poi/features/notifications/data/resources/notifications_end_point.dart';

abstract class NotificationsRemoteDataSource {
  Future<Unit> sendFcmToken(SendFcmTokenDto request);
}

class NotificationsRemoteDataSourceImpl extends NotificationsRemoteDataSource {
  final http.Client _client;

  NotificationsRemoteDataSourceImpl(this._client);

  @override
  Future<Unit> sendFcmToken(SendFcmTokenDto request) async {
    final response = await _client.post(
      Uri.parse(NotificationsEndPoint.sendFcmToken),
      body: request.toJson(),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
