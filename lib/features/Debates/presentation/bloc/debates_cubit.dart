import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/domain/usecases/get_debates_usecase.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class DebatesCubit extends Cubit<DebatesStates> {
  DebatesCubit({required this.getDebatesUseCase})
    : super(DebatesInitialState());
  static DebatesCubit get(context) => BlocProvider.of(context);

 int currentPage = 1;
  bool hasMore = true;
  bool isLoading = false;
  List<Datum> debatesList = [];

  final GetDebatesUseCase getDebatesUseCase;

  
void getAnnouncedDebates({int page = 1}) async {
  isLoading = true;
  emit(DebatesLoadingState());

  currentPage = page;

  final failureOrDebates = await getDebatesUseCase(currentPage: currentPage);
  failureOrDebates.fold(
    (failure) {
      isLoading = false;
      emit(DebatesGetDebatesErrorState(
        errorMessage: mapFailureToMessage(failure),
      ));
    },
    (data) {
      isLoading = false;
      debatesList = data.data;
      emit(DebatesGetDebatesSuccessState(debatesData: data));
    },
  );
}

  
  void changePage(int pageNumber) {
    getAnnouncedDebates(page: pageNumber);
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
