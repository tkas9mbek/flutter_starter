import 'package:bloc/bloc.dart';
import 'package:starter/features/application/environment/domain/environment_repository.dart';
import 'package:starter/features/application/environment/model/app_environment.dart';

class EnvironmentCubit extends Cubit<AppEnvironment> {
  EnvironmentCubit(this._repository) : super(_repository.getEnvironment());

  final EnvironmentRepository _repository;

  Future<void> setEnvironment(AppEnvironment environment) async {
    await _repository.changeEnvironment(environment);

    emit(environment);
  }
}
