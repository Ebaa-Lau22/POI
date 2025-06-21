import 'package:bloc/bloc.dart';
import 'package:poi/features/debate_setup/presentation/bloc/team_assignment_states.dart';

class DebateSetupCubit extends Cubit<DebateSetupStates> {
  DebateSetupCubit() : super(DebateSetupInitialState());

  List<String> allSides = ['og', 'oo', 'cg', 'co'];
  List<String> currentTeams = ['og', 'oo', 'cg', 'co'];

  void randomizeSides() {
    currentTeams.shuffle();
    emit(DebateSetupChangeTeamAssignmentState());
  }
}

