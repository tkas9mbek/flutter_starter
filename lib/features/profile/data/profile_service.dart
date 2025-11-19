import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starter/features/profile/model/user.dart';

part 'profile_service.g.dart';

@RestApi()
abstract class ProfileService {
  factory ProfileService(Dio dio, {required String baseUrl}) = _ProfileService;

  @GET('profile')
  Future<User> getUserProfile();
}
