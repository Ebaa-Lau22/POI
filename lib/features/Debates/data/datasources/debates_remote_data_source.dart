import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/base_model.dart';
import 'package:poi/core/dio/api_service.dart';
import 'package:poi/features/Debates/data/datasources/debates_end_points.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/add_feedback_response_model.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/dto/add_feedback_dto.dart';
import 'package:poi/features/Debates/data/models/dto/rate_judge_dto.dart';
import 'package:poi/features/Debates/data/models/dto/send_request_from_judge_dto.dart';
import 'package:poi/features/Debates/data/models/feedback_model.dart';
import 'package:poi/features/Debates/data/models/get_feedback_for_debater_response_model.dart';
import 'package:poi/features/Debates/data/models/new_motion_model.dart';

abstract class DebatesRemoteDataSource {
  Future<DebateModel> getAnnouncedDebates({required DebatesStatus status});
  Future<BaseResponse<List<NewMotionModel>>> getMotions();
  Future<FeedbackModel> getFeedback(int debateId);
  Future<AddFeedbackResponseModel> addFeedback(AddFeedbackDto feedback);
  // Todo add the response model when you know it
  Future<Unit> rateJudge(RateJudgeDto rateJudge);
  // Todo add the response model when you know it
  Future<Unit> sendRequestFromJudge(
    SendRequestFromJudgeDto sendRequestFromJudge,
  );
  // Todo add the response model when you know it
  Future<Unit> sendRequestFromDebater(int debateid);
  // Todo add the response model when you know it
  Future<GetFeedbackByDebaterResponseModel> getFeedbackByDebater();
}

class DebatesRemoteDataSourceImpl implements DebatesRemoteDataSource {
  final ApiServices apiServices;

  DebatesRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<DebateModel> getAnnouncedDebates({
    required DebatesStatus status,
  }) async {
    final response = await apiServices.get(
      DebatesEndPoints.getDebates,
      queryParams: {'status[]': status.serverName},
    );
    return DebateModel.fromJson(response);
  }

  @override
  Future<BaseResponse<List<NewMotionModel>>> getMotions() async {
    final response = await apiServices.get(DebatesEndPoints.getMotions);

    return BaseResponse.fromJson(response, (data) {
      List<dynamic> motionsData = data['data'][0] as List<dynamic>;

      return motionsData
          .map((e) => NewMotionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<FeedbackModel> getFeedback(int debateId) async {
    final response = await apiServices.get(
      DebatesEndPoints.getFeedback(debateId),
    );
    return FeedbackModel.fromJson(response);
  }

  @override
  Future<AddFeedbackResponseModel> addFeedback(AddFeedbackDto feedback) async {
    final response = await apiServices.post(
      DebatesEndPoints.addFeedback,
      body: feedback.toJson(),
    );
    return AddFeedbackResponseModel.fromJson(response);
  }

  @override
  Future<Unit> rateJudge(RateJudgeDto rateJudge) async {
    await apiServices.post(
      DebatesEndPoints.rateJudge,
      body: rateJudge.toJson(),
    );
    return unit;
  }

  @override
  Future<Unit> sendRequestFromJudge(
    SendRequestFromJudgeDto sendRequestFromJudge,
  ) async {
    await apiServices.post(
      DebatesEndPoints.sendRequestFromJudge(sendRequestFromJudge.debateid),
      body: sendRequestFromJudge.toJson(),
    );
    return unit;
  }

  @override
  Future<Unit> sendRequestFromDebater(int debateid) async {
    await apiServices.post(DebatesEndPoints.sendRequestFromDebater(debateid));
    return unit;
  }

  @override
  Future<GetFeedbackByDebaterResponseModel> getFeedbackByDebater() async {
    final response = await apiServices.get(
      DebatesEndPoints.getFeedbackByDebater,
    );
    return GetFeedbackByDebaterResponseModel.fromJson(response);
  }
}
