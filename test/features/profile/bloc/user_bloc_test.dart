import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/ui/bloc/user_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor.dart';

import '../model/profile_mock_models.dart';

class MockProfileDataSource extends Mock implements ProfileDataSource {}

void main() {
  late UserBloc userBloc;
  late MockProfileDataSource mockDataSource;
  late ProfileRepository profileRepository;

  setUp(() {
    mockDataSource = MockProfileDataSource();
    profileRepository = ProfileRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      mockDataSource,
    );
    userBloc = UserBloc(profileRepository);
  });

  test('initial state is initial()', () {
    expect(userBloc.state, const UserState.initial());
  });

  group('on requested() event', () {
    blocTest<UserBloc, UserState>(
      'emits [loading, success] when getUserProfile is successful',
      build: () {
        when(() => mockDataSource.getUserProfile())
            .thenAnswer((_) async => ProfileMockModels.user);

        return userBloc;
      },
      act: (bloc) => bloc.add(const UserEvent.requested()),
      expect: () => [
        const UserState.loading(),
        UserState.success(ProfileMockModels.user),
      ],
      verify: (_) {
        verify(() => mockDataSource.getUserProfile()).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [loading, failure] when getUserProfile fails',
      build: () {
        when(() => mockDataSource.getUserProfile())
            .thenThrow(const NoInternetException());

        return userBloc;
      },
      act: (bloc) => bloc.add(const UserEvent.requested()),
      expect: () => [
        const UserState.loading(),
        const UserState.failure(NoInternetException()),
      ],
      verify: (_) {
        verify(() => mockDataSource.getUserProfile()).called(1);
      },
    );

    blocTest<UserBloc, UserState>(
      'emits [loading, failure] with server error',
      build: () {
        when(() => mockDataSource.getUserProfile())
            .thenThrow(const ServerException(statusCode: 500));

        return userBloc;
      },
      act: (bloc) => bloc.add(const UserEvent.requested()),
      expect: () => [
        const UserState.loading(),
        predicate<UserState>(
          (state) => state.whenOrNull(
                failure: (exception) => exception is ServerException,
              ) ==
              true,
        ),
      ],
      verify: (_) {
        verify(() => mockDataSource.getUserProfile()).called(1);
      },
    );
  });

  group('on updated() event', () {
    blocTest<UserBloc, UserState>(
      'emits success state with updated user',
      build: () => userBloc,
      act: (bloc) => bloc.add(UserEvent.updated(ProfileMockModels.updatedUser)),
      expect: () => [
        UserState.success(ProfileMockModels.updatedUser),
      ],
    );

    blocTest<UserBloc, UserState>(
      'replaces previous success state with new user',
      build: () => userBloc,
      seed: () => UserState.success(ProfileMockModels.user),
      act: (bloc) => bloc.add(UserEvent.updated(ProfileMockModels.updatedUser)),
      expect: () => [
        UserState.success(ProfileMockModels.updatedUser),
      ],
    );
  });

  group('state helper methods', () {
    const initialState = UserState.initial();
    const loadingState = UserState.loading();
    final successState = UserState.success(ProfileMockModels.user);
    const failureState = UserState.failure(NoInternetException());

    test('isLoading returns true for loading state', () {
      userBloc.emit(loadingState);
      expect(userBloc.state.isLoading, isTrue);
    });

    test('isLoading returns false for non-loading states', () {
      userBloc.emit(initialState);
      expect(userBloc.state.isLoading, isFalse);

      userBloc.emit(successState);
      expect(userBloc.state.isLoading, isFalse);

      userBloc.emit(failureState);
      expect(userBloc.state.isLoading, isFalse);
    });
  });
}
