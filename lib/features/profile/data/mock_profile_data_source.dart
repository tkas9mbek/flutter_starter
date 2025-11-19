import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';

class MockProfileDataSource implements ProfileDataSource {
  const MockProfileDataSource();

  @override
  Future<User> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Return mock user profile
    return User(
      id: 'mock_user_id_12345',
      name: 'John Doe',
      phone: '+1234567890',
      birthday: DateTime(1990, 5, 15),
    );
  }
}
