import 'dart:convert';
import 'dart:io';

import 'package:starter/features/profile/model/user.dart';

class ProfileMockModels {
  static dynamic getJsonFromFile(String fileName) {
    const basePath = 'test/features/profile/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static Map<String, dynamic> get rawUser =>
      getJsonFromFile('user.json') as Map<String, dynamic>;

  static Map<String, dynamic> get rawUpdatedUser =>
      getJsonFromFile('user_updated.json') as Map<String, dynamic>;

  static User get user => User.fromJson(rawUser);

  static User get updatedUser => User.fromJson(rawUpdatedUser);
}
