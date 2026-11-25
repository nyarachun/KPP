import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/show_message.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/auth_layout.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../data/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendLink() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await AuthRepository.instance.resetPassword(email: _emailController.text.trim());
      if (mounted) showMessage(context, 'Reset link sent. Check your email (and spam folder).');
    } catch (e) {
      if (mounted) showMessage(context, AuthRepository.errorMessage(e), isError: true);
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'A secure way back to your volunteer work.',
      description: 'Enter your email and we will send you a link to choose a new password.',
      headerTrailing: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            Image.asset('assets/icons/arrow_left.png', width: 16),
            const SizedBox(width: 8),
            Text(
              'Back',
              style: AppTextStyles.body(13, color: AppColors.hint, weight: FontWeight.w600),
            ),
          ],
        ),
      ),
      card: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reset password', style: AppTextStyles.title(40)),
            const SizedBox(height: 8),
            Text('Open the link from the email to set a new password.', style: AppTextStyles.body(15)),
            const SizedBox(height: 24),
            CustomTextField(
              label: 'Email',
              hint: 'you@example.com',
              icon: 'assets/icons/mail.png',
              controller: _emailController,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Send reset link',
              icon: 'assets/icons/send.png',
              width: double.infinity,
              isLoading: _isLoading,
              onPressed: _sendLink,
            ),
          ],
        ),
      ),
    );
  }
}
