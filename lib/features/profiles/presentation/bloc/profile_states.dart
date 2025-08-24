import 'package:poi/core/app_models/profile_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileGetProfileSuccessState extends ProfileStates {
  ProfileModel profileData;
  ProfileGetProfileSuccessState({
    required this.profileData,
  });
}

class ProfileGetprofileErrorState extends ProfileStates {
  String errorMessage;
  ProfileGetprofileErrorState({required this.errorMessage});
}
