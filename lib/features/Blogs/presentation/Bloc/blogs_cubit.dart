import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/features/profiles/domain/usecases/get_profile_usecase.dart';
import 'package:poi/features/profiles/presentation/bloc/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit({required this.getProfileUseCase})
    : super(ProfileInitialState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  final GetProfileUseCase getProfileUseCase;
  void getProfile() async {
    emit(ProfileLoadingState());
    final failureOrProfile = await getProfileUseCase();
    failureOrProfile.fold(
      (failure) {
        emit(
          ProfileGetprofileErrorState(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        emit(ProfileGetProfileSuccessState(profileData: data));
      },
    );
  }

  ProfileStates failureOrSuccessMessage<E>(
    Either<Failure, E> either,
    String successMessage,
    ProfileStates Function(String) onError,
    ProfileStates Function(E) onSuccess,
  ) {
    return either.fold(
      (failure) => onError(mapFailureToMessage(failure)),
      (data) => onSuccess(data),
    );
  }
}
