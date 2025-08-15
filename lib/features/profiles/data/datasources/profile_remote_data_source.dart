import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poi/core/app_entities/profile_entity.dart';
import 'package:poi/core/app_models/profile_model.dart';
import 'package:poi/core/error/exceptions.dart';
import 'package:poi/core/storage/preferences_database.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});

  String baseUrl = "https://b490a975cc17.ngrok-free.app/api";

  @override
  Future<ProfileModel> getProfile() async {
    final prefs = PreferencesDatabase();
    final savedToken = await prefs.getToken();
    if (savedToken == null) {
      throw Exception("No token found in secure storage.");
    }
    final response = await client.get(
      Uri.parse("${baseUrl}/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $savedToken",
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final loginResponse = ProfileModel.fromJson(jsonData);
      print(loginResponse);
      return loginResponse;
    } else if (response.statusCode == 401) {
      await prefs.removeValue('AUTH_TOKEN');
      throw Exception("Session expired. Please log in again.");
    } else {
      throw Exception("Failed to load profile: ${response.statusCode}");
    }
  }
}
