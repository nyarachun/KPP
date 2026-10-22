import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_layout.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'A secure way back to your volunteer work.',
      description: 'Verify your email with a one-time code, then choose a new password for your account.',
      cardWidth: 700,
      headerTrailing: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Row(
          children: [
            Image.asset('assets/icons/arrow_left.png', width: 16),
            const SizedBox(width: 8),
            Text('Back', style: AppTextStyles.body(13, color: AppColors.hint, weight: FontWeight.w600)),
          ],
        ),
      ),
      card: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _StepTitle(number: '1', text: 'Send a verification code'),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'Email',
            hint: 'you@example.com',
            icon: 'assets/icons/mail.png',
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Send code',
            icon: 'assets/icons/send.png',
            width: double.infinity,
            onPressed: () {},
          ),
          const Divider(color: AppColors.border, height: 64),
          const _StepTitle(number: '2', text: 'Enter the code'),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'Verification code',
            hint: '6-digit code',
            icon: 'assets/icons/key.png',
          ),
          const Divider(color: AppColors.border, height: 64),
          const _StepTitle(number: '3', text: 'Choose a new password'),
          const SizedBox(height: 16),
          const CustomTextField(
            label: 'New password',
            hint: 'At least 8 characters',
            icon: 'assets/icons/lock.png',
            isPassword: true,
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Confirm new password',
            icon: 'assets/icons/check.png',
            width: double.infinity,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _StepTitle extends StatelessWidget {
  final String number;
  final String text;
  const _StepTitle({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.chip,
          child: Text(number, style: AppTextStyles.body(13, color: AppColors.primary, weight: FontWeight.w700)),
        ),
        const SizedBox(width: 12),
        Text(text, style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600)),
      ],
    );
  }
}
