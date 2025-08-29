import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Search/data/models/user_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchGetUsersLoadingState extends SearchStates {}

class SearchGetFinishedDebatesLoadingState extends SearchStates {}

class SearchGetUsersSuccessState extends SearchStates {
  List<UserData> usersData;
  SearchGetUsersSuccessState({required this.usersData});
}

class SearchGetUsersErrorState extends SearchStates {
  String errorMessage;
  SearchGetUsersErrorState({required this.errorMessage});
}

class SearchGetFinishedDebatesSuccessState extends SearchStates {
  List<Datum> finishedDebatesData;
  SearchGetFinishedDebatesSuccessState({required this.finishedDebatesData});
}

class SearchGetFinishedDebatesErrorState extends SearchStates {
  String errorMessage;
  SearchGetFinishedDebatesErrorState({required this.errorMessage});
}
