import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:poi/core/app_entities/motion_entity.dart';
import 'package:poi/features/debate_setup/data/datasources/debate_setup_remote_datasource.dart';
import 'package:poi/features/debate_setup/domain/usecases/get_all_motions_usecase.dart';
import 'package:poi/features/debate_setup/presentation/bloc/debate_setup_states.dart';

import '../../../../core/function/error_message.dart';
import '../../domain/usecases/get_all_topics_usecase.dart';

class DebateSetupCubit extends Cubit<DebateSetupStates> {
  DebateSetupCubit({
    required this.getAllMotionsUsecase,
    required this.getAllTopicsUsecase}
      ) : super(DebateSetupInitialState());

  List<String> allSides = ['og', 'oo', 'cg', 'co'];
  List<String> currentTeams = ['og', 'oo', 'cg', 'co'];

  void randomizeSides() {
    currentTeams.shuffle();
    emit(DebateSetupChangeTeamAssignmentState());
  }

  List<String> allTopics = [];
  List<String> selectedTopics = [];
  List<String> selectedTopicsCopy = [];

  GetAllTopicsUsecase getAllTopicsUsecase;
  void getAllTopics() async{
    emit(DebateSetupGetAllTopicsLoadingState());
    final failureOrPosts = await getAllTopicsUsecase();
    failureOrPosts.fold(
          (failure) {
        emit(DebateSetupGetAllTopicsErrorState(
            message: mapFailureToMessage(failure)));
      },
          (topicsList) {
        allTopics = topicsList;
        emit(DebateSetupGetAllTopicsSuccessState());
      },
    );
  }

  List<MotionEntity> allMotions = [];
  List<MotionEntity> filteredMotions = [];
  MotionEntity? selectedMotion;
  GetAllMotionsUsecase getAllMotionsUsecase;
  void getAllMotions() async{
    emit(DebateSetupGetAllMotionsLoadingState());
    final failureOrPosts = await getAllMotionsUsecase();
    failureOrPosts.fold(
          (failure) {
        emit(DebateSetupGetAllMotionsErrorState(
            message: mapFailureToMessage(failure)));
      },
          (motionsList) {
        allMotions = motionsList;
        filteredMotions = allMotions;
        selectedMotion = allMotions[0];
        emit(DebateSetupGetAllMotionsSuccessState());
      },
    );
  }

  void selectMotion(MotionEntity motion){
    selectedMotion = motion;
    emit(DebateSetupMotionSelectState());
  }

  void randomizeMotion(){
    int index = Random().nextInt(filteredMotions.length);
    selectMotion(filteredMotions[index]);
  }

  void toggleTopic(String topic) {
    if (selectedTopicsCopy.contains(topic)) {
      selectedTopicsCopy.remove(topic);
    } else {
      selectedTopicsCopy.add(topic);
    }
    emit(DebateSetupChangeTopicState());
  }

  String _searchQuery = '';
  void searchMotions(String query) {
    _searchQuery = query;
    applyFilters();
  }

  //filter based on topic and search query
  void applyFilters() {
    selectedTopics = selectedTopicsCopy.sublist(0);
    filteredMotions = allMotions.where((m) {
      final bool matchesTopic;
      if(selectedTopics.isEmpty) {
        matchesTopic = true;
      } else{
        matchesTopic= m.topics.any((e) => selectedTopics.contains(e));
      }
      final bool matchesSearch = _searchQuery.isEmpty || m.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesTopic && matchesSearch;
    }).toList();
    emit(DebateSetupMotionsFilteredState());
  }

  String selectedTopic = "Economical";

  List<String> newMotionSelectedTopics = [];
  void addTopicToNewMotion(String topic) {
    if (!newMotionSelectedTopics.contains(topic)) {
      newMotionSelectedTopics.add(topic);
      if(newMotionSelectedTopics.length>2) newMotionSelectedTopics.removeAt(0);
    }
    else{
      newMotionSelectedTopics.remove(topic);
    }
    emit(DebateSetupAddTopicToNewMotionState());
  }

}
