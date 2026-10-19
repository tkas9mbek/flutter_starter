import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/profile/data/api_profile_data_source.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';

import '../model/profile_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late ApiProfileDataSource dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ApiProfileDataSource(mockApiClient);
  });

  group('getUserProfile', () {
    test('returns User when API call is successful', () async {
      when(
        () => mockApiClient.requestJson<User>(
          method: HttpMethod.get,
          path: '/profile',
          fromJson: any(named: 'fromJson'),
        ),
      ).thenAnswer((invocation) async {
        final fromJson =
            invocation.namedArguments[#fromJson]
                as User Function(Map<String, dynamic>);

        return fromJson(ProfileMockModels.rawUser);
      });

      final result = await dataSource.getUserProfile();

      expect(result, equals(ProfileMockModels.user));
      expect(result.birthday, DateTime(1990));
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

      expect(() => dataSource.getUserProfile(), throwsA(isA<Exception>()));
    });
  });
}
