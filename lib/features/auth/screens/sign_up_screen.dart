import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/show_message.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/auth_layout.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../data/auth_repository.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await AuthRepository.instance.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // The user is signed in now, go back to AuthGate which shows HomeScreen.
      if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (mounted) {
        showMessage(context, AuthRepository.errorMessage(e), isError: true);
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      eyebrow: 'Start organizing',
      title: 'Turn good intentions into local action.',
      description: 'Create one account to publish events, welcome volunteers, and stay connected to your community.',
      cardWidth: 560,
      card: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CREATE YOUR ACCOUNT', style: AppTextStyles.eyebrow(11)),
            const SizedBox(height: 8),
            Text('Sign up', style: AppTextStyles.title(40)),
            const SizedBox(height: 8),
            Text('Use an email you check regularly.', style: AppTextStyles.body(16)),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Name',
              hint: 'Alex Morgan',
              controller: _nameController,
              validator: (v) => Validators.required(v, 'Name'),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Email',
              hint: 'you@example.com',
              controller: _emailController,
              validator: Validators.email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Password',
              hint: 'At least 8 characters',
              isPassword: true,
              controller: _passwordController,
              validator: Validators.password,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Confirm password',
              hint: 'Re-enter your password',
              isPassword: true,
              validator: (v) => v != _passwordController.text ? 'Passwords do not match' : null,
            ),
            const SizedBox(height: 24),
            CustomButton(text: 'Create account', width: double.infinity, isLoading: _isLoading, onPressed: _signUp),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ', style: AppTextStyles.body(14)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Sign in.',
                    style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600),
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
