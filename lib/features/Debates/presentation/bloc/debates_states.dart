import 'package:poi/features/Debates/data/models/debates_model.dart';

abstract class DebatesStates {}

class DebatesInitialState extends DebatesStates {}

class DebatesLoadingState extends DebatesStates {}

class DebatesGetDebatesSuccessState extends DebatesStates {
  DebatesModel debatesData;
  DebatesGetDebatesSuccessState({
    required this.debatesData,
  });
}

class DebatesGetDebatesErrorState extends DebatesStates {
  String errorMessage;
  DebatesGetDebatesErrorState({required this.errorMessage});
}
