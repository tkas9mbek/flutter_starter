import 'package:starter/features/auth/domain/auth_authorized_data_source.dart';

class MockAuthAuthorizedDataSource implements AuthAuthorizedDataSource {
  const MockAuthAuthorizedDataSource();

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));

    return;
  }
}
