import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:poi/core/app_cubit/state_cubit.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/enums/judge_type.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/dto/send_request_from_judge_dto.dart';
import 'package:poi/features/Debates/domain/usecases/get_debates_usecase.dart';
import 'package:poi/features/Debates/domain/usecases/send_request_from_debater_use_case.dart';
import 'package:poi/features/Debates/domain/usecases/send_request_from_judge_use_case.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class DebatesCubit extends Cubit<DebatesStates> {
  DebatesCubit({
    required this.getDebatesUseCase,
    required this.sendRequestFromJudgeUseCase,
    required this.sendRequestFromDebaterUseCase,
  }) : super(DebatesInitialState());
  static DebatesCubit get(context) => BlocProvider.of(context);
  List<DebateData> debatesList = [];
  StateCubit<DebatesStatus> currentStatusCubit = StateCubit(
    initialValue: DebatesStatus.announced,
  );

  final GetDebatesUseCase getDebatesUseCase;
  final SendRequestFromJudgeUseCase sendRequestFromJudgeUseCase;
  final SendRequestFromDebaterUseCase sendRequestFromDebaterUseCase;

  void onPageChanged(int index) {
    currentStatusCubit.changeValue(DebatesStatus.values[index]);
    getAnnouncedDebates();
  }

  void getAnnouncedDebates() async {
    emit(DebatesLoadingState());

    final failureOrDebates = await getDebatesUseCase(
      status: currentStatusCubit.value,
    );
    failureOrDebates.fold(
      (failure) {
        emit(
          DebatesGetDebatesErrorState(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        debatesList = data.data;
        emit(DebatesGetDebatesSuccessState(debates: data.data));
      },
    );
  }

  Future<void> toggleJoinJudge({
    required int index,
    required SendRequestFromJudgeDto request,
    required BuildContext context,
  }) async {
    context.loaderOverlay.show();
    final response = await sendRequestFromJudgeUseCase.call(
      sendRequestFromJudge: request,
    );
    response.fold(
      (error) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(mapFailureToMessage(error))));
      },
      (right) {
        context.loaderOverlay.hide();
        if (request.judgeType == JudgeType.chair) {
          debatesList[index] = debatesList[index].copyWith(
            isJoinedAsChairJudge: true,
          );
        } else {
          debatesList[index] = debatesList[index].copyWith(
            isJoinedAsPanelistJudge: true,
          );
        }
        emit(DebatesGetDebatesSuccessState(debates: debatesList));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Joined as ${request.judgeType.name}")),
        );
      },
    );
  }

  Future<void> toggleApply({
    required int index,
    required int debateId,
    required BuildContext context,
  }) async {
    context.loaderOverlay.show();
    final response = await sendRequestFromDebaterUseCase.call(
      debateid: debateId,
    );
    response.fold(
      (error) {
        context.loaderOverlay.hide();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(mapFailureToMessage(error))));
      },
      (right) {
        context.loaderOverlay.hide();
        debatesList[index] = debatesList[index].copyWith(isAbleToApply: false);
        emit(DebatesGetDebatesSuccessState(debates: debatesList));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Joined the debate")));
      },
    );
  }

  DebatesStates failureOrSuccessMessage<E>(
    Either<Failure, E> either,
    String successMessage,
    DebatesStates Function(String) onError,
    DebatesStates Function(E) onSuccess,
  ) {
    return either.fold(
      (failure) => onError(mapFailureToMessage(failure)),
      (data) => onSuccess(data),
    );
  }
}
