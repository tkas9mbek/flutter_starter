import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/profile/data/remote_profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late RemoteProfileDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = RemoteProfileDataSource(mockApiClient);
  });

  group('getUserProfile', () {
    final mockUser = User(
      id: '1',
      name: 'John Doe',
      phone: '+79991234567',
      birthday: DateTime(1990, 1, 1),
    );

    test('returns User when API call is successful', () async {
      when(
        () => mockApiClient.requestJson<User>(
          method: HttpMethod.get,
          path: '/profile',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((_) async => mockUser);

      final result = await dataSource.getUserProfile();

      expect(result, equals(mockUser));
      verify(
        () => mockApiClient.requestJson<User>(
          method: HttpMethod.get,
          path: '/profile',
          fromJson: any(named: 'fromJson'),
        ),
      ).called(1);
    });

    test('throws exception when API call fails', () async {
      when(
        () => mockApiClient.requestJson<User>(
          method: HttpMethod.get,
          path: '/profile',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.getUserProfile(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
