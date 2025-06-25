import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/app_models/motion_model.dart';

import '../../../../core/constants/appLink.dart';
import '../../../../core/error/exceptions.dart';

abstract class DebateSetupRemoteDatasource {
  Future<List<MotionModel>> getAllMotions();
  Future<List<String>> getAllTopics();
  Future<Unit> addMotion(MotionModel motion);
}

class DebateSetupRemoteDatasourceImpl extends DebateSetupRemoteDatasource {
  final http.Client client;

  DebateSetupRemoteDatasourceImpl({required this.client});

  @override
  Future<Unit> addMotion(MotionModel motion) async {
    final body = motion.toJson();
    final response = await client.post(
      Uri.parse("${AppLink}/"), //TODO: add url
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MotionModel>> getAllMotions() async {
    return Future.value(motions); //TODO: add url
    final response = await client.get(
      Uri.parse("${AppLink.postUrl}/posts"), //TODO: add url
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      List<MotionModel> models = decodedJson.map<MotionModel>((jsonMotionModel) => MotionModel.fromJson(jsonMotionModel)).toList();
      return Future.value(models);
    } else {
      throw ServerException();
    }
  }

  Future<List<String>> getAllTopics() async {
    return Future.value(topics); //TODO: add url
    final response = await client.get(
      Uri.parse("${AppLink.postUrl}/posts"), //TODO: add url
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      List<String> models = decodedJson as List<String>;
      return Future.value(models);
    } else {
      throw ServerException();
    }
  }
}
final motions = [
  MotionModel(
    title: "This House would ban single-use plastics",
    topics: ["Educational", "Social", "Ecological"],
  ),
  MotionModel(
    title: "This House supports universal basic income",
    topics: ["Social", "Ecological", "Educational"],
  ),
  MotionModel(
    title: "This House would require companies to disclose their carbon footprint",
    topics: ["Social", "Educational", "Ecological"],
  ),
  MotionModel(
    title: "This House believes cryptocurrencies do more harm than good",
    topics: ["Social", "Educational", "Ecological"],
  ),
  MotionModel(
    title: "This House would lower the voting age to 16",
    topics: ["Educational", "Economical", "Social"],
  ),
  MotionModel(
    title: "This House supports mandatory military service",
    topics: ["Economical", "Social", "Ecological"],
  ),
  MotionModel(
    title: "This House would regulate AI more strictly",
    topics: ["Legal", "Political", "Economical"],
  ),
  MotionModel(
    title: "This House believes that the media is a threat to democracy",
    topics: ["Political", "Legal", "Social"],
  ),
  MotionModel(
    title: "This House supports allowing students to evaluate their teachers",
    topics: ["Educational", "Economical", "Political"],
  ),
  MotionModel(
    title: "This House would criminalize hate speech on social media",
    topics: ["Legal", "Economical", "Political"],
  ),
  MotionModel(
    title: "This House believes global organizations do more harm than good",
    topics: ["Educational", "Political", "Economical"],
  ),
];

final topics = ['Economical', 'Political', 'Educational', 'Ecological', 'Legal', 'Social'];
