import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/features/Authentication/domain/usecases/logout_use_case.dart';
import 'package:poi/features/Authentication/presentation/bloc/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit({required this.logoutUseCase}) : super(LogoutInitialState());
  static LogoutCubit get(context) => BlocProvider.of(context);

  final LogoutUseCase logoutUseCase;
  Future<void> logout(BuildContext context) async {
    emit(LogoutLoadingState());
    final response = await logoutUseCase();
    response.fold(
      (failure) {
        emit(
          LogoutErrorState(
            errorMessage: "Something went wrong try again later",
          ),
        );
      },
      (unit) async {
        final prefs = PreferencesDatabase();
        await prefs.clearToken();
        emit(LogoutSuccessState());
      },
    );
  }
}
