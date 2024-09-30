import 'package:dio/dio.dart';
import 'package:flutter_starter/core/data/model/api_response.dart';
import 'package:flutter_starter/features/post/core/model/comment.dart';
import 'package:flutter_starter/features/post/core/model/post.dart';

import 'package:retrofit/retrofit.dart';

part 'post_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio, {required String baseUrl}) = _PostApi;

  @GET('posts')
  Future<List<Post>> getPost();

  @GET('posts/{id}')
  Future<Post> getPostById(
    @Path('id') int id,
  );

  @GET('posts/{id}/comments')
  Future<List<Comment>> getCommentsByPostId(
    @Path('id') int id,
  );

  @POST('posts')
  Future<Post> createPost(
    @Body() Post post,
  );

  @PUT('posts/{id}')
  Future<Post> updatePost(
    @Path('id') int id,
    @Body() Post post,
  );

  @DELETE('posts/{id}')
  Future<void> deletePost(
    @Path('id') int id,
  );
}
