import 'dart:developer' as developer;

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../widgets/coral_header.dart';

/// Login / Sign-in screen with email and password fields.
///
/// Validates that the email matches a standard format and the
/// password is at least 8 characters long.
class LoginScreen extends StatefulWidget {
  /// Creates the login screen.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      developer.log(
        'Login attempt: ${_emailController.text}',
        name: 'demoapp.login',
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successful!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const CoralHeader(heightFraction: 0.35),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              _SignInTitle(textTheme: textTheme),
                              const SizedBox(height: 32),
                              _EmailField(controller: _emailController),
                              const SizedBox(height: 20),
                              _PasswordField(
                                controller: _passwordController,
                                obscure: _obscurePassword,
                                onToggleObscure: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _RememberForgotRow(
                                rememberMe: _rememberMe,
                                onChanged: (v) =>
                                    setState(() => _rememberMe = v),
                              ),
                              const Spacer(),
                              _LoginButton(onPressed: _onLogin),
                              const SizedBox(height: 16),
                              const _SignUpRow(),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// "Sign in" heading with a coral underline accent.
class _SignInTitle extends StatelessWidget {
  const _SignInTitle({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sign in', style: textTheme.headlineMedium),
        const SizedBox(height: 4),
        Container(
          width: 74,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

/// Email text field with a mail icon prefix and format validation.
class _EmailField extends StatelessWidget {
  const _EmailField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'demo@email.com',
        prefixIcon: Icon(Icons.mail_outline, size: 18),
      ),
      validator: _validateEmail,
    );
  }

  /// Returns an error message if [value] is not a valid email.
  static String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}

/// Password text field with a lock icon prefix, visibility toggle,
/// and a minimum-length validator.
class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.obscure,
    required this.onToggleObscure,
  });

  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggleObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'enter your password',
        prefixIcon: const Icon(Icons.lock_outline, size: 18),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 18,
          ),
          onPressed: onToggleObscure,
        ),
      ),
      validator: _validatePassword,
    );
  }

  /// Returns an error message if [value] is shorter than 8 characters.
  static String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}

/// Row with a "Remember Me" checkbox and a "Forgot Password?" link.
class _RememberForgotRow extends StatelessWidget {
  const _RememberForgotRow({required this.rememberMe, required this.onChanged});

  final bool rememberMe;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: rememberMe,
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                side: const BorderSide(color: AppColors.primary),
                onChanged: (v) => onChanged(v ?? false),
              ),
            ),
            const SizedBox(width: 4),
            Text('Remember Me', style: textTheme.bodySmall),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'Forgot Password?',
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Full-width "Login" elevated button.
class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: const Text('Login'));
  }
}

/// "Don't have an Account? Sign up" footer row.
class _SignUpRow extends StatelessWidget {
  const _SignUpRow();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an Account ? ",
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textLight),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Sign up',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
