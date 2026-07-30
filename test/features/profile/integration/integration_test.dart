import 'package:flutter_test/flutter_test.dart';
import 'package:starter/features/profile/data/mock_profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_data_source.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/model/user.dart';
import 'package:starter/features/profile/ui/overview/bloc/user_bloc.dart';
import 'package:starter_toolkit/data/exceptions/app_exception.dart';
import 'package:starter_toolkit/data/repository_executor/raw_repository_executor.dart';
import 'package:starter_toolkit/data/repository_executor/repository_executor_extensions.dart';

class _ThrowingProfileDataSource implements ProfileDataSource {
  const _ThrowingProfileDataSource();

  @override
  Future<User> getUserProfile() async => throw const NoInternetException();
}

void main() {
  UserBloc buildBloc(ProfileDataSource dataSource) => UserBloc(
    ProfileRepository(
      const RawRepositoryExecutor().withErrorHandling(),
      dataSource,
    ),
  );

  Future<void> settle(UserBloc bloc) => bloc.stream.firstWhere(
    (state) => state is SuccessUserState || state is FailureUserState,
  );

  test('profile flow reaches a success state', () async {
    final bloc = buildBloc(const MockProfileDataSource());

    bloc.add(const UserEvent.requested());
    await settle(bloc);

    expect(bloc.state, isA<SuccessUserState>());
  });

  test('profile flow surfaces a failure end-to-end', () async {
    final bloc = buildBloc(const _ThrowingProfileDataSource());

    bloc.add(const UserEvent.requested());
    await settle(bloc);

    expect(bloc.state, isA<FailureUserState>());
  });
}
