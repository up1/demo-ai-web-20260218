import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/welcome_screen.dart';

/// Creates a new [GoRouter] instance for the application.
///
/// Defines two routes:
/// - `/` — the Welcome / Startup screen
/// - `/login` — the Login / Sign-in screen
GoRouter createAppRouter() => GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const WelcomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),
      ],
    ),
  ],
);
