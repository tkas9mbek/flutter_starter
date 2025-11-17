import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';
import 'package:starter/features/auth/model/user.dart';

class MockAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  const MockAuthAuthorizedDataSource();

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

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));

    return;
  }
}
