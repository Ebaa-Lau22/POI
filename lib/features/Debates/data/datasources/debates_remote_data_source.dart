import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';

abstract class DebatesRemoteDataSource {
  Future<DebatesModel> getAnnouncedDebates({required int currentPage});
}

class DebatesRemoteDataSourceImpl implements DebatesRemoteDataSource {
  final http.Client client;

  DebatesRemoteDataSourceImpl({required this.client});
    int currentPage = 1;
  bool hasMore = true;
  bool isLoading = false;
  List<Datum> debatesList = [];

  String baseUrl = "http://31.97.46.191/api";
  final prefs = PreferencesDatabase();

  @override
  Future<DebatesModel> getAnnouncedDebates({required int currentPage}) async {
    final savedToken = await prefs.getToken();
    if (savedToken == null) {
      throw Exception("No token found in secure storage.");
    }
    final response = await client.get(
      Uri.parse("${baseUrl}/debates?page=${currentPage}&status[]=announced"),
      
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $savedToken",
      },

    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final debatesResponse = DebatesModel.fromJson(jsonData);
      print(debatesResponse);
      return debatesResponse;
    } else {
      throw Exception("Failed to load Debates: ${response.statusCode}");
    }
  }

}
