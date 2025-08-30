import 'package:poi/core/app_models/new_profile_model.dart';
import 'package:poi/core/dio/api_service.dart';
import 'package:poi/features/profiles/data/datasources/profile_end_points.dart';

abstract class NewProfileRemoteDataSource {
  Future<NewProfileModel> getProfile();
}

class NewProfileRemoteDataSourceImpl implements NewProfileRemoteDataSource {
  final ApiServices _apiServices;
  NewProfileRemoteDataSourceImpl(this._apiServices);

  @override
  Future<NewProfileModel> getProfile() async {
    final response = await _apiServices.get(ProfileEndPoints.profile);
    return NewProfileModel.fromJson(response);
  }
}
