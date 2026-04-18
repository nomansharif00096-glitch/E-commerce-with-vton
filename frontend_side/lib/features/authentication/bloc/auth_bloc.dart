import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/features/authentication/authentication.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final AuthService authService;
  AuthBloc({required this.authRepository, required this.authService})
      : super(const AuthState()) {
    on<CreateUser>(onCreateUser);
    on<LoginUser>(onLoginUser);
    on<LogoutUser>(onLogoutUser);
    on<LoadUser>(onLoadUser);
    on<ToggleLogin>(onToggleLogin);
  }
  Future<void> onCreateUser(CreateUser event, Emitter<AuthState> emit) async {
    emit(state.copywith(userStatus: UserStatus.loading));
    final result = await authRepository.register(event.params);
    result.fold((failure) {
      emit(state.copywith(userStatus: UserStatus.error));
    }, (data) {
      emit(state.copywith(userStatus: UserStatus.loaded));
    });
  }

  Future<void> onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(state.copywith(userStatus: UserStatus.loading));
    final result = await authRepository.login(event.params);
    await result.fold((failure) {
      emit(
          state.copywith(userStatus: UserStatus.error, error: failure.message));
    }, (data) async {
      final userData = UserData(
          name: data.user.name,
          email: data.user.email,
          id: data.user.id,
          accessToken: data.accessToken);
      await authService.saveUserData(userData).then((value) {
        if (value != null) {
          emit(state.copywith(
              userStatus: UserStatus.loaded, userData: userData));
        }
      });
    });
  }

  Future<void> onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(state.copywith(showLogin: !state.showLogin));
    authService.deleteUserData();
  }

  Future<void> onLoadUser(LoadUser event, Emitter<AuthState> emit) async {
    emit(state.copywith(userData: null, userStatus: UserStatus.initial));
    authService.deleteUserData();
  }

  void onToggleLogin(ToggleLogin event, Emitter<AuthState> emit) async {
    emit(state.copywith(showLogin: !state.showLogin));
  }
}
