import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

/// Root application widget.
///
/// Configures the [MaterialApp.router] with the coral-pink theme
/// from the Figma designs and the [GoRouter]-based navigation.
class MyApp extends StatelessWidget {
  /// Creates the root application widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DemoApp',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      routerConfig: createAppRouter(),
    );
  }
}
