import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../widgets/coral_header.dart';

/// Startup / Welcome screen — the first screen the user sees.
///
/// Displays a large coral header with a topographic pattern,
/// the "Welcome" title, a subtitle, and a "Continue" button
/// that navigates to the login screen.
class WelcomeScreen extends StatelessWidget {
  /// Creates the welcome screen.
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CoralHeader(heightFraction: 0.6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text('Welcome', style: textTheme.displayLarge),
                  const SizedBox(height: 16),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur.\n'
                    'Lorem id sit',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  const Spacer(flex: 2),
                  _ContinueButton(onPressed: () => context.go('/login')),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A "Continue" text + arrow-circle button aligned to the right.
class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Continue', style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(width: 16),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
