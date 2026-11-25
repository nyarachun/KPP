import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/show_message.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/auth_layout.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../data/auth_repository.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await AuthRepository.instance.signIn(email: _emailController.text.trim(), password: _passwordController.text);
      // After sign in AuthGate shows HomeScreen automatically.
    } catch (e) {
      if (mounted) showMessage(context, AuthRepository.errorMessage(e), isError: true);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      eyebrow: 'Welcome back',
      title: 'Make a difference, one event at a time.',
      description: 'Join neighbors and student groups organizing practical volunteer events in their communities.',
      card: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('WELCOME BACK', style: AppTextStyles.eyebrow(11)),
            const SizedBox(height: 12),
            Text('Sign in', style: AppTextStyles.title(48)),
            const SizedBox(height: 12),
            Text('Continue organizing events that bring people together.', style: AppTextStyles.body(15)),
            const Divider(color: AppColors.border, height: 64),
            CustomTextField(
              label: 'Email',
              hint: 'you@example.com',
              icon: 'assets/icons/mail.png',
              controller: _emailController,
              validator: Validators.email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Password',
              hint: 'Enter your password',
              icon: 'assets/icons/lock.png',
              isPassword: true,
              controller: _passwordController,
              validator: (v) => Validators.required(v, 'Password'),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                child: Text(
                  'Forgot password?',
                  style: AppTextStyles.body(14, color: AppColors.primary, weight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(text: 'Sign In', width: double.infinity, isLoading: _isLoading, onPressed: _signIn),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New to Civicly?', style: AppTextStyles.body(14)),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                  child: Text(
                    'Create an account',
                    style: AppTextStyles.body(14, color: AppColors.primary, weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
