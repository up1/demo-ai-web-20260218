import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:demoapp/main.dart';

void main() {
  group('WelcomeScreen', () {
    testWidgets('shows Welcome text and Continue button', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('navigates to Login screen on Continue tap', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(find.text('Sign in'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });
  });

  group('LoginScreen', () {
    Future<void> navigateToLogin(WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
    }

    testWidgets('shows email and password fields', (tester) async {
      await navigateToLogin(tester);

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('shows error for invalid email', (tester) async {
      await navigateToLogin(tester);

      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'not-an-email');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('shows error for short password', (tester) async {
      await navigateToLogin(tester);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'test@email.com');
      await tester.enterText(fields.at(1), 'short');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must be at least 8 characters'),
        findsOneWidget,
      );
    });

    testWidgets('shows success on valid login', (tester) async {
      await navigateToLogin(tester);

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'test@email.com');
      await tester.enterText(fields.at(1), 'password123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Login successful!'), findsOneWidget);
    });
  });
}
