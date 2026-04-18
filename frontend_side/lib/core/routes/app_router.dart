import 'package:flutter/material.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:frontend_side/features/authentication/presentation/pages/auth_view.dart';
import 'package:frontend_side/features/cart/cart.dart';
import 'package:frontend_side/features/products/models/model.dart';
import 'package:frontend_side/features/products/presentation/presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_side/features/homescreen/home_screen.dart';
import 'package:animations/animations.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.homeView.route,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.homeView.name,
                path: AppRoutes.homeView.route,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: HomeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child);
                      });
                }),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.search.name,
                path: AppRoutes.search.route,
                pageBuilder: (context, state) {
                  final customColors =
                      Theme.of(context).extension<CustomColors>()!;
                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: Center(
                        child: Container(
                            height: 100,
                            width: 100,
                            color: customColors.mainColor,
                            child: Text(AppRoutes.search.route)),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child);
                      });
                }),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.favorites.name,
                path: AppRoutes.favorites.route,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: SizedBox(
                        child: Text(
                          'Favourites',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child);
                      });
                }),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                name: AppRoutes.profile.name,
                path: AppRoutes.profile.route,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                      key: state.pageKey,
                      child: ProfileScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child);
                      });
                }),
          ]),
        ],
      ),
      GoRoute(
          name: AppRoutes.productDetail.name,
          path: AppRoutes.productDetail.route,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
                key: state.pageKey,
                child: ProductDetails(id: state.uri.queryParameters['id']!),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child);
                });
          }),
      GoRoute(
          name: AppRoutes.productsBasedOnCategory.name,
          path: AppRoutes.productsBasedOnCategory.route,
          pageBuilder: (context, state) {
            final CategoryModel categoryModel = state.extra as CategoryModel;
            return CustomTransitionPage(
                key: state.pageKey,
                child: ProductsBasedOnCategories(categoryModel: categoryModel),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child);
                });
          }),
      GoRoute(
          name: AppRoutes.cartView.name,
          path: AppRoutes.cartView.route,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
                key: state.pageKey,
                child: const CartPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child);
                });
          }),
      GoRoute(
          name: AppRoutes.auth.name,
          path: AppRoutes.auth.route,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
                key: state.pageKey,
                child: const AuthPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SharedAxisTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                      child: child);
                });
          }),
    ],
  );
}
