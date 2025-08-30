import 'package:dartz/dartz.dart';
import 'package:poi/core/app_models/base_model.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/network/network_info.dart';
import 'package:poi/features/Debates/data/datasources/debates_remote_data_source.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/add_feedback_response_model.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/dto/add_feedback_dto.dart';
import 'package:poi/features/Debates/data/models/dto/rate_judge_dto.dart';
import 'package:poi/features/Debates/data/models/dto/send_request_from_judge_dto.dart';
import 'package:poi/features/Debates/data/models/feedback_model.dart';
import 'package:poi/features/Debates/data/models/get_feedback_for_debater_response_model.dart';
import 'package:poi/features/Debates/data/models/new_motion_model.dart';
import 'package:poi/features/Debates/data/models/rate_judge_response_model.dart';
import 'package:poi/features/Debates/domain/repositories/debates_repository.dart';

class DebatesRepositoryImpl implements DebatesRepository {
  final DebatesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DebatesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DebateModel>> getAnnouncedDebates({
    required DebatesStatus status,
  }) async {
    try {
      final remotedebates = await remoteDataSource.getAnnouncedDebates(
        status: status,
      );
      return Right(remotedebates);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponse<List<NewMotionModel>>>>
  getMotions() async {
    try {
      final remoteMotions = await remoteDataSource.getMotions();
      return Right(remoteMotions);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FeedbackModel>> getFeedback(int debateId) async {
    try {
      final remoteFeedback = await remoteDataSource.getFeedback(debateId);
      return Right(remoteFeedback);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, AddFeedbackResponseModel>> addFeedback(
    AddFeedbackDto feedback,
  ) async {
    try {
      final remoteFeedback = await remoteDataSource.addFeedback(feedback);
      return Right(remoteFeedback);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RateJudgeResponseModel>> rateJudge(RateJudgeDto rateJudge) async {
    try {
      final remoteRateJudge = await remoteDataSource.rateJudge(rateJudge);
      return Right(remoteRateJudge);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendRequestFromJudge(
    SendRequestFromJudgeDto sendRequestFromJudge,
  ) async {
    try {
      final remoteSendRequestFromJudge = await remoteDataSource
          .sendRequestFromJudge(sendRequestFromJudge);
      return Right(remoteSendRequestFromJudge);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendRequestFromDebater(int debateid) async {
    try {
      final remoteSendRequestFromDebater = await remoteDataSource
          .sendRequestFromDebater(debateid);
      return Right(remoteSendRequestFromDebater);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetFeedbackByDebaterResponseModel>>
  getFeedbackByDebater() async {
    try {
      final remoteGetFeedbackByDebater =
          await remoteDataSource.getFeedbackByDebater();
      return Right(remoteGetFeedbackByDebater);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, DebateModel>> getFinishedDebates() async {
    try {
      final result = await remoteDataSource.getFinishedDebates();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
