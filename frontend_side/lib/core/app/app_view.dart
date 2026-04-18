import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/di/injection_container.dart';
import 'package:frontend_side/core/routes/app_router.dart';
import 'package:frontend_side/core/theme/theme.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:frontend_side/features/cart/presentation/presentation.dart';
import 'package:frontend_side/features/products/bloc/bloc.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<ProductBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<CartCubit>()..readAllCarts(),
        ),
        BlocProvider(create: (_) => locator<ThemeBloc>()),
        BlocProvider(create: (_) => locator<AuthBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return AnimatedTheme(
            data: state.themeData,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MaterialApp.router(
              color: Colors.white,
              debugShowCheckedModeBanner: false,
              title: 'Shop',
              theme: state.themeData,
              routerConfig: locator<AppRouter>().router,
            ),
          );
        },
      ),
    );
  }
}
