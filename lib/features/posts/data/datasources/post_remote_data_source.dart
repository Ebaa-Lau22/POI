import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:poi/core/constants/appLink.dart';
import 'package:poi/core/error/exceptions.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse("${AppLink.postUrl}/posts"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      List<PostModel> posts = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(posts);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};
    final response = await client.post(
      Uri.parse("${AppLink.postUrl}/posts/"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if(response.statusCode == 201){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async{
    final response = await client.delete(
      Uri.parse("${AppLink.postUrl}/posts/${postId.toString()}}"),
      headers: {"Content-Type": "application/json"},
    );
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async{
    final postId = postModel.id;
    final body = {"title": postModel.title, "body": postModel.body};
    final response = await client.patch(
      Uri.parse("${AppLink.postUrl}/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
}
