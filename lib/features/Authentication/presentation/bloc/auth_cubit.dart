import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit({required this.loginUseCase}) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  final LoginUseCase loginUseCase;
  void login({required LoginEntity login_entity}) async {
    emit(AuthLoginLoadingState());
    final unitOrFailure = await loginUseCase(loginEntity: login_entity);
    emit(_failureOrSuccessMessage(unitOrFailure, LOGIN_SUCCESS_MESSAGE));
  }

  AuthStates _failureOrSuccessMessage(
    Either<Failure, Unit> either,
    String message,
  ) {
    return either.fold(
      (failure) {
        return AuthLoginErrorState(errorMessage: mapFailureToMessage(failure));
      },
      (_) {
        return AuthLoginSuccessState(successMessage: message);
      },
    );
  }
}
