import 'package:poi/core/dio/api_service.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Search/data/datasource/search_end_points.dart';
import 'package:poi/features/Search/data/models/user_model.dart';

abstract class SearchRemoteDataSource {
  Future<UserModel> getUsers();
  Future<DebatesModel> getFinishedDebates();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiServices apiServices;

  SearchRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<UserModel> getUsers() async {
    final response = await apiServices.get(SearchEndPoints.users);
    return UserModel.fromJson(response);
  }

  @override
  Future<DebatesModel> getFinishedDebates() async {
    final response = await apiServices.get(SearchEndPoints.finishedDebates);
    return DebatesModel.fromJson(response);
  }
}
