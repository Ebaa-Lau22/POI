import 'package:bloc/bloc.dart';
import 'package:poi/features/team_assignment/presentation/bloc/team_assignment_states.dart';

class TeamAssignmentCubit extends Cubit<TeamAssignmentStates> {
  TeamAssignmentCubit() : super(TeamAssignmentInitialState());

  List<String> allSides = ['og', 'oo', 'cg', 'co'];
  List<String> currentTeams = ['og', 'oo', 'cg', 'co'];

  void randomizeSides() {
    currentTeams.shuffle();
    emit(TeamAssignmentChangeTeamAssignmentState());
  }

  bool isMicEnabled = false;
  bool isCameraEnabled = false;

}

