import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/state_cubit.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:poi/core/logger/logger.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Search/data/enum/filter_enum.dart';
import 'package:poi/features/Search/data/models/user_model.dart';
import 'package:poi/features/Search/domain/usecase/get_finished_debates_use_case.dart';
import 'package:poi/features/Search/domain/usecase/get_users_use_case.dart';
import 'package:poi/features/Search/presentation/bloc/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit({
    required this.getUsersUseCase,
    required this.getFinishedDebatesUseCase,
  }) : super(SearchInitialState());

  final GetUsersUseCase getUsersUseCase;
  final GetFinishedDebatesUseCase getFinishedDebatesUseCase;
  final StateCubit<FilterEnum> selectedFilter = StateCubit(
    initialValue: FilterEnum.people,
  );
  List<UserData> users = [];
  List<Datum> finishedDebates = [];
  TextEditingController searchController = TextEditingController();

  void onFilterChanged(FilterEnum filter) {
    searchController.clear();
    selectedFilter.changeValue(filter);
    if (filter == FilterEnum.people) {
      getUsers();
    } else {
      getFinishedDebates();
    }
  }

  void onSearchQueryChanged(String query) {
    searchController.text = query;
    if (selectedFilter.value == FilterEnum.people) {
      searchUser();
    } else {
      searchFinishedDebates();
    }
  }

  void searchUser() async {
    List<UserData> filteredUsers =
        users
            .where(
              (user) =>
                  user.firstName.contains(searchController.text) ||
                  user.lastName.contains(searchController.text) ||
                  user.email.contains(searchController.text),
            )
            .toList();
    emit(SearchGetUsersSuccessState(usersData: filteredUsers));
  }

  void searchFinishedDebates() async {
    // Todo filter the debates like the user based on some attributes
  }

  Future<void> getUsers() async {
    emit(SearchGetUsersLoadingState());
    final result = await getUsersUseCase();
    result.fold(
      (failure) {
        emit(
          SearchGetUsersErrorState(errorMessage: mapFailureToMessage(failure)),
        );
      },
      (data) {
        users = data.data;
        emit(SearchGetUsersSuccessState(usersData: data.data));
      },
    );
  }

  Future<void> getFinishedDebates() async {
    emit(SearchGetFinishedDebatesLoadingState());
    final result = await getFinishedDebatesUseCase();
    result.fold(
      (failure) {
        emit(
          SearchGetFinishedDebatesErrorState(
            errorMessage: mapFailureToMessage(failure),
          ),
        );
      },
      (data) {
        finishedDebates = data.data;
        emit(
          SearchGetFinishedDebatesSuccessState(finishedDebatesData: data.data),
        );
      },
    );
  }
}
