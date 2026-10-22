import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_layout.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/screens/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      eyebrow: 'Start organizing',
      title: 'Turn good intentions into local action.',
      description: 'Create one account to publish events, welcome volunteers, and stay connected to your community.',
      cardWidth: 560,
      card: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CREATE YOUR ACCOUNT', style: AppTextStyles.eyebrow(11)),
          const SizedBox(height: 8),
          Text('Sign up', style: AppTextStyles.title(40)),
          const SizedBox(height: 8),
          Text('Use an email you check regularly.', style: AppTextStyles.body(16)),
          const SizedBox(height: 24),
          const CustomTextField(label: 'Email', hint: 'you@example.com'),
          const SizedBox(height: 20),
          const CustomTextField(label: 'Password', hint: '•••••', isPassword: true),
          const SizedBox(height: 8),
          const SizedBox(height: 20),
          const CustomTextField(label: 'Confirm password', hint: 'Re-enter your password', isPassword: true),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Create account',
            width: double.infinity,
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ', style: AppTextStyles.body(14)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text('Sign in.', style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
