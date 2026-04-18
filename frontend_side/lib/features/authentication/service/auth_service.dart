import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService {
  Future<UserData?> saveUserData(UserData user) async {
    Box<UserData> userBox = Hive.box<UserData>('user');
    await userBox.put('user', user);
    return user;
  }

  Future<UserData?> getUserData() async {
    Box<UserData> userBox = Hive.box<UserData>('user');
    return userBox.get('user');
  }

  void deleteUserData() async {
    Box<UserData> userBox = Hive.box<UserData>('user');
    userBox.clear();
  }
}
