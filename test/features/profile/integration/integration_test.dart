import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/profile/data/remote_profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter/features/profile/ui/bloc/user_bloc.dart';
import 'package:starter_toolkit/data/client/api_client.dart';
import 'package:starter_toolkit/data/client/http_method.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/profile_mock_models.dart';

class MockApiClient extends Mock implements ApiClient {}

User _fakeFromJson(Map<String, dynamic> json) => User.fromJson(json);

/// Integration test: UserBloc → ProfileRepository → RemoteProfileDataSource → ApiClient (mocked)
///
/// Tests the full flow from BLoC through Repository and DataSource with only ApiClient mocked.
void main() {
  late UserBloc userBloc;
  late ProfileRepository profileRepository;
  late ProfileDataSource profileDataSource;
  late MockApiClient mockApiClient;

  setUpAll(() {
    registerFallbackValue(HttpMethod.get);
    registerFallbackValue(_fakeFromJson);
  });

  setUp(() {
    mockApiClient = MockApiClient();
    profileDataSource = RemoteProfileDataSource(mockApiClient);
    profileRepository = ProfileRepository(
      const RawRepositoryExecutor()
          .withErrorHandling()
          .withRetry(maxRetries: 3, retryDelay: const Duration(seconds: 2)),
      profileDataSource,
    );
    userBloc = UserBloc(profileRepository);
  });

  test('initial state is initial()', () {
    expect(userBloc.state, const UserState.initial());
  });

  group('getUserProfile flow', () {
    blocTest<UserBloc, UserState>(
      'completes full successful flow: BLoC → Repository → DataSource → ApiClient',
      build: () {
        when(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: '/profile',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => ProfileMockModels.user);

        return userBloc;
      },
      act: (bloc) => bloc.add(const UserEvent.requested()),
      expect: () => [
        const UserState.loading(),
        UserState.success(ProfileMockModels.user),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: '/profile',
            fromJson: any(named: 'fromJson'),
          ),
        ).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'handles network error through full stack',
      build: () {
        when(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: '/profile',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const NoInternetException());

        return userBloc;
      },
      act: (bloc) => bloc.add(const UserEvent.requested()),
      wait: const Duration(seconds: 8),
      expect: () => [
        const UserState.loading(),
        const UserState.failure(NoInternetException()),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: '/profile',
            fromJson: any(named: 'fromJson'),
          ),
        ).called(greaterThan(1)); // Called multiple times due to retry
      },
    );

    blocTest<UserBloc, UserState>(
      'handles server error through full stack',
      build: () {
        when(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: '/profile',
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(const ServerException(statusCode: 500));

        return userBloc;
      },
      act: (bloc) => bloc.add(const UserEvent.requested()),
      wait: const Duration(seconds: 8),
      expect: () => [
        const UserState.loading(),
        predicate<UserState>(
          (state) => state.whenOrNull(
                failure: (exception) => exception is ServerException,
              ) ??
              false,
        ),
      ],
      verify: (_) {
        verify(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: '/profile',
            fromJson: any(named: 'fromJson'),
          ),
        ).called(greaterThan(1)); // Called multiple times due to retry
      },
    );
  });

  group('updateUser flow', () {
    blocTest<UserBloc, UserState>(
      'updates user state directly without API call',
      build: () => userBloc,
      act: (bloc) => bloc.add(UserEvent.updated(ProfileMockModels.updatedUser)),
      expect: () => [
        UserState.success(ProfileMockModels.updatedUser),
      ],
      verify: (_) {
        verifyNever(
          () => mockApiClient.requestJson<User>(
            method: any(named: 'method'),
            path: any(named: 'path'),
            fromJson: any(named: 'fromJson'),
          ),
        );
      },
    );
  });
}
