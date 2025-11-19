import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {required String baseUrl}) = _AuthService;

  @POST('auth/logout')
  Future<void> logout();

  @POST('auth/login')
  Future<AuthToken> login(@Body() AuthLoginRequestBody body);

  @POST('auth/register')
  Future<AuthToken> register(@Body() AuthRegisterRequestBody body);
}
