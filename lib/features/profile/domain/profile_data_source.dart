import 'package:starter/features/profile/model/user.dart';

abstract class ProfileDataSource {
  Future<User> getUserProfile();
}
