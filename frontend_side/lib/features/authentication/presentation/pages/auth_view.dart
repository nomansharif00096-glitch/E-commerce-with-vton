import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/features/authentication/authentication.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final showLogin = context.select((AuthBloc bloc) => bloc.state.showLogin);
    return PageTransitionSwitcher(
      reverse: showLogin,
      transitionBuilder: (child, animation, secondaryAnimation) {
        return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child);
      },
      child: showLogin ? const LoginPage() : const SignUpPage(),
    );
  }
}
