import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';

class MockProfileDataSource implements ProfileDataSource {
  const MockProfileDataSource();

  @override
  Future<User> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));

    return User(
      id: 'mock_id',
      name: 'Mock User',
      phone: '+1234567890',
      birthday: DateTime(1990, 5, 15),
    );
  }
}
