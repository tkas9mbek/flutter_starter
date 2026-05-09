import 'dart:convert';
import 'dart:io';

import 'package:starter/features/profile/model/user.dart';

class ProfileMockModels {
  static dynamic _getJsonFromFile(String fileName) {
    const basePath = 'test/features/profile/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static final Map<String, dynamic> _rawUser =
      _getJsonFromFile('user.json') as Map<String, dynamic>;
  static final Map<String, dynamic> _rawUpdatedUser =
      _getJsonFromFile('user_updated.json') as Map<String, dynamic>;

  static final User _user = User.fromJson(_rawUser);
  static final User _updatedUser = User.fromJson(_rawUpdatedUser);

  static Map<String, dynamic> get rawUser =>
      Map<String, dynamic>.from(_rawUser);

  static Map<String, dynamic> get rawUpdatedUser =>
      Map<String, dynamic>.from(_rawUpdatedUser);

  static User get user => _user;

  static User get updatedUser => _updatedUser;
}
