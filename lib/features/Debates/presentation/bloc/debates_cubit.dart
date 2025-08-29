import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/state_cubit.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/core/logger/logger.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/domain/usecases/get_debates_usecase.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class DebatesCubit extends Cubit<DebatesStates> {
  DebatesCubit({required this.getDebatesUseCase})
    : super(DebatesInitialState());
  static DebatesCubit get(context) => BlocProvider.of(context);
  List<Datum> debatesList = [];
  StateCubit<DebatesStatus> currentStatusCubit = StateCubit(
    initialValue: DebatesStatus.announced,
  );

  final GetDebatesUseCase getDebatesUseCase;

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
        emit(DebatesGetDebatesSuccessState(debatesData: data));
      },
    );
  }

  void toggleApply(int index) {
    final currentState = state;
    if (currentState is DebatesGetDebatesSuccessState) {
      final debatesData = currentState.debatesData;

      final updatedList = List<Datum>.from(debatesData.data);

      updatedList[index] = updatedList[index].copyWith(isAbleToApply: false);

      emit(
        DebatesGetDebatesSuccessState(
          debatesData: debatesData.copyWith(data: updatedList),
        ),
      );
    }
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
