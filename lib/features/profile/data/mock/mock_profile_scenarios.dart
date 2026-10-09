import 'package:starter/features/profile/model/user.dart';

abstract final class MockProfileScenarios {
  static final user = User(
    id: 'mock_user_id_12345',
    name: 'John Doe',
    phone: '+1234567890',
    birthday: DateTime(1990, 5, 15),
  );
}
