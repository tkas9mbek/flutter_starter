import 'dart:async';

import 'package:flutter_starter/core/data/repository_executor/repository_executor.dart';
import 'package:flutter_starter/features/post/core/data/post_api.dart';
import 'package:flutter_starter/features/post/core/model/post.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostRepository {
  final RepositoryExecutor _repositoryExecutor;
  final PostApi _postApi;

  PostRepository(
    this._repositoryExecutor,
    this._postApi,
  );

  Future<List<Post>> getPosts() async =>
      _repositoryExecutor.execute(_postApi.getPost);

  Future<Post> getPostById(int id) async =>
      _repositoryExecutor.execute(() => _postApi.getPostById(id));

  Future<Post> createPost(Post post) async =>
      _repositoryExecutor.execute(() => _postApi.createPost(post));

  Future<Post> updatePost(Post post) async =>
      _repositoryExecutor.execute(() => _postApi.updatePost(post.id, post));

  Future<void> deletePost(int id) async =>
      _repositoryExecutor.execute(() => _postApi.deletePost(id));
}
