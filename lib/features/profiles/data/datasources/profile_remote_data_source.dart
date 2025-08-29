import 'package:poi/core/app_models/profile_model.dart';
import 'package:poi/core/dio/api_service.dart';
import 'package:poi/core/storage/preferences_database.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiServices apiServices;

  ProfileRemoteDataSourceImpl({required this.apiServices});

  String baseUrl = "https://b490a975cc17.ngrok-free.app/api";

  @override
  Future<ProfileModel> getProfile() async {
    final prefs = PreferencesDatabase();
    final savedToken = await prefs.getToken();
    if (savedToken == null) {
      throw Exception("No token found in secure storage.");
    }
    final response = await apiServices.get("profile");

    return ProfileModel.fromJson(response);
  }
}
