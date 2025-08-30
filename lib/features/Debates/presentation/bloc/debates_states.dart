import 'package:poi/features/Debates/data/models/add_feedback_response_model.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/rate_judge_response_model.dart';

abstract class DebatesStates {}

class DebatesInitialState extends DebatesStates {}

class DebatesLoadingState extends DebatesStates {}

class DebatesGetDebatesSuccessState extends DebatesStates {
  List<DebateData> debates;
  DebatesGetDebatesSuccessState({required this.debates});
}

class DebatesGetDebatesErrorState extends DebatesStates {
  String errorMessage;
  DebatesGetDebatesErrorState({required this.errorMessage});
}

class AddFeedbackLoading extends DebatesStates {}

class AddFeedbackSuccess extends DebatesStates {
  final AddFeedbackResponseModel response;
  AddFeedbackSuccess({required this.response});
}

class AddFeedbackError extends DebatesStates {
  final String message;
  AddFeedbackError(this.message);
}

class RateJudgeLoading extends DebatesStates {}

class RateJudgeSuccess extends DebatesStates {
  final RateJudgeResponseModel response;
  RateJudgeSuccess({required this.response});
}

class RateJudgeError extends DebatesStates {
  final String message;
  RateJudgeError(this.message);
}

class GetConfirmedDebatesLoadingState extends DebatesStates {}


class GetConfirmedDebatesSuccessState extends DebatesStates {
  List<DebateData> ConfirmedDebatesData;
  GetConfirmedDebatesSuccessState({required this.ConfirmedDebatesData});
}

class GetConfirmedDebatesErrorState extends DebatesStates {
  String errorMessage;
  GetConfirmedDebatesErrorState({required this.errorMessage});
}

