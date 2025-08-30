import 'package:poi/core/app_models/base_model.dart';
import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/add_feedback_response_model.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/dto/add_feedback_dto.dart';
import 'package:poi/features/Debates/data/models/dto/rate_judge_dto.dart';
import 'package:poi/features/Debates/data/models/dto/send_request_from_judge_dto.dart';
import 'package:poi/features/Debates/data/models/feedback_model.dart';
import 'package:poi/features/Debates/data/models/get_feedback_for_debater_response_model.dart';
import 'package:poi/features/Debates/data/models/new_motion_model.dart';

abstract class DebatesRepository {
  Future<Either<Failure, DebateModel>> getAnnouncedDebates({
    required DebatesStatus status,
  });
  Future<Either<Failure, BaseResponse<List<NewMotionModel>>>> getMotions();
  Future<Either<Failure, FeedbackModel>> getFeedback(int debateId);
  Future<Either<Failure, AddFeedbackResponseModel>> addFeedback(
    AddFeedbackDto feedback,
  );
  Future<Either<Failure, Unit>> rateJudge(RateJudgeDto rateJudge);
  Future<Either<Failure, Unit>> sendRequestFromJudge(
    SendRequestFromJudgeDto sendRequestFromJudge,
  );
  Future<Either<Failure, Unit>> sendRequestFromDebater(int debateid);
  Future<Either<Failure, GetFeedbackByDebaterResponseModel>>
  getFeedbackByDebater();
}
