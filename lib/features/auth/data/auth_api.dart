import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/model/user.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {required String baseUrl}) = _AuthApi;

  @GET('auth/profile')
  Future<User> getUserProfile();

  @POST('auth/logout')
  Future<void> logout();

  @POST('auth/login')
  Future<AuthToken> login(@Body() AuthLoginRequestBody body);

  @POST('auth/register')
  Future<AuthToken> register(@Body() AuthRegisterRequestBody body);
}
