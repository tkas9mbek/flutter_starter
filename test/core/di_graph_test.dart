import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/core/di/app_configurator.dart';
import 'package:starter/core/global/global_variables.dart';
import 'package:starter/core/notifications/domain/push_notification_repository.dart';
import 'package:starter/core/notifications/domain/push_token_repository.dart';
import 'package:starter/core/remote_config/domain/remote_config_repository.dart';
import 'package:starter/core/remote_config/model/remote_general_settings.dart';
import 'package:starter/core/remote_config/model/remote_phone_codes.dart';
import 'package:starter/core/remote_config/ui/bloc/remote_configs_bloc.dart';
import 'package:starter/features/auth/domain/auth_repository.dart';
import 'package:starter/features/auth/ui/login/bloc/login_bloc.dart';
import 'package:starter/features/auth/ui/otp/bloc/otp_bloc.dart';
import 'package:starter/features/auth/ui/register/bloc/registration_bloc.dart';
import 'package:starter/features/profile/domain/profile_repository.dart';
import 'package:starter/features/profile/ui/overview/bloc/user_bloc.dart';
import 'package:starter/features/settings/domain/settings_repository.dart';
import 'package:starter/features/task/domain/task_repository.dart';
import 'package:starter/features/task/ui/calendar/bloc/calendar_bloc.dart';
import 'package:starter/features/task/ui/create/bloc/task_creation_bloc.dart';
import 'package:starter/features/task/ui/details/bloc/task_delete_bloc.dart';
import 'package:starter/features/task/ui/list/bloc/tasks_list_bloc.dart';
import 'package:starter/features/task/ui/search/bloc/tasks_search_bloc.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
          (call) async => null,
        );

    await getIt.reset();
    await AppConfigurator.configure();
  });

  tearDown(() async => getIt.reset());

  test('core and feature repositories resolve', () {
    expect(getIt<AuthRepository>(), isA<AuthRepository>());
    expect(getIt<SettingsRepository>(), isA<SettingsRepository>());
    expect(getIt<ProfileRepository>(), isA<ProfileRepository>());
    expect(getIt<TaskRepository>(), isA<TaskRepository>());
    expect(getIt<RemoteConfigRepository>(), isA<RemoteConfigRepository>());
    expect(
      getIt<PushNotificationRepository>(),
      isA<PushNotificationRepository>(),
    );
    expect(getIt<PushTokenRepository>(), isA<PushTokenRepository>());
  });

  test('GetIt-registered blocs resolve', () {
    expect(getIt<CalendarBloc>(), isA<CalendarBloc>());
    expect(getIt<TasksListBloc>(), isA<TasksListBloc>());
    expect(getIt<TasksSearchBloc>(), isA<TasksSearchBloc>());
    expect(getIt<TaskCreationBloc>(), isA<TaskCreationBloc>());
    expect(getIt<TaskDeleteBloc>(), isA<TaskDeleteBloc>());
    expect(getIt<LoginBloc>(), isA<LoginBloc>());
    expect(getIt<RegistrationBloc>(), isA<RegistrationBloc>());
    expect(getIt<OtpBloc>(), isA<OtpBloc>());
    expect(getIt<UserBloc>(), isA<UserBloc>());
    expect(
      getIt<RemoteConfigsBloc<RemoteGeneralSettings>>(),
      isA<RemoteConfigsBloc<RemoteGeneralSettings>>(),
    );
    expect(
      getIt<RemoteConfigsBloc<RemotePhoneCodes>>(),
      isA<RemoteConfigsBloc<RemotePhoneCodes>>(),
    );
  });
}
