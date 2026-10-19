import 'package:starter/features/auth/data/mock/mock_auth_scenarios.dart';
import 'package:starter/features/auth/domain/auth_unauthorized_data_source.dart';
import 'package:starter/features/auth/model/auth_login_request_body.dart';
import 'package:starter/features/auth/model/auth_otp_request_body.dart';
import 'package:starter/features/auth/model/auth_register_request_body.dart';
import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/auth/model/auth_verify_otp_request_body.dart';
import 'package:starter_toolkit/data/mock/mock_network_behavior.dart';

class MockAuthUnauthorizedDataSource implements AuthUnauthorizedDataSource {
  const MockAuthUnauthorizedDataSource(this._network);

  final MockNetworkBehavior _network;

  @override
  Future<AuthToken> login(AuthLoginRequestBody body) async {
    await _network.simulate();

    return MockAuthScenarios.token;
  }

  @override
  Future<AuthToken> register(AuthRegisterRequestBody body) async {
    await _network.simulate();

    return MockAuthScenarios.token;
  }

  @override
  Future<void> requestOtp(AuthOtpRequestBody body) async {
    await _network.simulate();
  }

  @override
  Future<AuthToken> verifyOtp(AuthVerifyOtpRequestBody body) async {
    await _network.simulate();

    if (body.otp == MockAuthScenarios.wrongOtp) {
      throw MockAuthScenarios.wrongOtpRefusal();
    }

    return MockAuthScenarios.token;
  }
}
