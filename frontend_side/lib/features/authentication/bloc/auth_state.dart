import 'package:equatable/equatable.dart';
import 'package:frontend_side/features/authentication/authentication.dart';

enum UserStatus { initial, loading, loaded, error }

class AuthState extends Equatable {
  final UserStatus userStatus;
  final UserData? userData;
  final bool showLogin;
  final String? error;
  const AuthState(
      {this.userStatus = UserStatus.initial,
      this.userData,
      this.error,
      this.showLogin = false});
  AuthState copywith(
      {UserStatus? userStatus,
      UserData? userData,
      String? error,
      bool? showLogin}) {
    return AuthState(
        userStatus: userStatus ?? this.userStatus,
        userData: userData ?? this.userData,
        error: error ?? this.error,
        showLogin: showLogin ?? this.showLogin);
  }

  @override
  List<Object?> get props => [userStatus, userData, error, showLogin];
}
