import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/error/failures.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/features/Authentication/domain/entities/auth.dart';
import 'package:poi/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:poi/features/Authentication/domain/usecases/resetPassword_usecase.dart';
import 'package:poi/features/Authentication/domain/usecases/sendCode_usecase.dart';
import 'package:poi/features/Authentication/domain/usecases/verifyCode_usecase.dart';
import 'package:poi/features/Authentication/presentation/bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit({
    required this.loginUseCase,
    required this.sendCodeUseCase,
    required this.verifyCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  final LoginUseCase loginUseCase;
  void login({required LoginEntity login_entity}) async {
    emit(AuthLoadingState());
    final unitOrFailure = await loginUseCase(loginEntity: login_entity);
    print(unitOrFailure);
    emit(
      _failureOrSuccessMessage(
        unitOrFailure,
        LOGIN_SUCCESS_MESSAGE,
        (error) => AuthLoginErrorState(errorMessage: error),
        (message) => AuthLoginSuccessState(successMessage: message),
      ),
    );
  }

  final SendCodeUseCase sendCodeUseCase;
  void sendCode({required SendCodeEntity sendCodeEntity}) async {
    emit(AuthLoadingState());
    final unitOrFailure = await sendCodeUseCase(sendCodeEntity: sendCodeEntity);
    emit(
      _failureOrSuccessMessage(
        unitOrFailure,
        SEND_CODE_SUCCESS_MESSAGE,
        (error) => AuthSendCodeErrorState(errorMessage: error),
        (message) => AuthSendCodeSuccessState(successMessage: message),
      ),
    );
  }

  final VerifyCodeUseCase verifyCodeUseCase;
  void verifyCode({
    required VerificationCodeEntity verificationCodeEntity,
  }) async {
    emit(AuthLoadingState());
    final unitOrFailure = await verifyCodeUseCase(
      verifyCodeEntity: verificationCodeEntity,
    );
    emit(
      _failureOrSuccessMessage(
        unitOrFailure,
        VERIFY_CODE_SUCCESS_MESSAGE,
        (error) => AuthVerifyCodeErrorState(errorMessage: error),
        (message) => AuthVerifyCodeSuccessState(successMessage: message),
      ),
    );
  }

  final ResetPasswordUseCase resetPasswordUseCase;
  void resetPassword({required ResetPasswordEntity resetPasswordEntity}) async {
    emit(AuthLoadingState());
    final unitOrFailure = await resetPasswordUseCase(
      resetPassEntity: resetPasswordEntity,
    );
    emit(
      _failureOrSuccessMessage(
        unitOrFailure,
        RESET_PASSWORD_SUCCESS_MESSAGE,
        (error) => AuthResetPasswordErrorState(errorMessage: error),
        (message) => AuthResetPasswordSuccessState(successMessage: message),
      ),
    );
  }

  AuthStates _failureOrSuccessMessage(
    Either<Failure, Unit> either,
    String message,
    AuthStates Function(String errorMessage) onError,
    AuthStates Function(String successMessage) onSuccess,
  ) {
    return either.fold(
      (failure) => onError(mapFailureToMessage(failure)),
      (_) => onSuccess(message),
    );
  }
}

  // AuthStates _failureOrSuccessMessage(
  //   Either<Failure, Unit> either,
  //   String message,
  // ) {
  //   return either.fold(
  //     (failure) {
  //       return AuthResetPasswordErrorState(errorMessage: mapFailureToMessage(failure));
  //     },
  //     (_) {
  //       return AuthResetPasswordSuccessState(successMessage: message);
  //     },
  //   );
  // }
