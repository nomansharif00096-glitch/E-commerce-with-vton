import 'package:equatable/equatable.dart';
import 'package:frontend_side/features/authentication/authentication.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateUser extends AuthEvent {
  final SignupParams params;
  CreateUser({required this.params});
  @override
  List<Object?> get props => [params];
}

class LoginUser extends AuthEvent {
  final Loginparam params;
  LoginUser({required this.params});
  @override
  List<Object?> get props => [params];
}

class LogoutUser extends AuthEvent {}

class LoadUser extends AuthEvent {}

class ToggleLogin extends AuthEvent {}
