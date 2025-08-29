import 'dart:async';

import 'package:poi/core/dio/api_service.dart';
import 'package:poi/features/Debates/data/datasources/debates_end_points.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';

abstract class DebatesRemoteDataSource {
  Future<DebatesModel> getAnnouncedDebates({required DebatesStatus status});
}

class DebatesRemoteDataSourceImpl implements DebatesRemoteDataSource {
  final ApiServices apiServices;

  DebatesRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<DebatesModel> getAnnouncedDebates({
    required DebatesStatus status,
  }) async {
    final response = await apiServices.get(
      DebatesEndPoints.getDebates,
      queryParams: {'status[]': status.serverName},
    );
    return DebatesModel.fromJson(response);
  }
}
