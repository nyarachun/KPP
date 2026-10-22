import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/auth_layout.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/screens/home_screen.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      eyebrow: 'Welcome back',
      title: 'Make a difference, one event at a time.',
      description: 'Join neighbors and student groups organizing practical volunteer events in their communities.',
      card: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('WELCOME BACK', style: AppTextStyles.eyebrow(11)),
          const SizedBox(height: 12),
          Text('Sign in', style: AppTextStyles.title(48)),
          const SizedBox(height: 12),
          Text('Continue organizing events that bring people together.', style: AppTextStyles.body(15)),
          const Divider(color: AppColors.border, height: 64),
          const CustomTextField(
            label: 'Email',
            hint: 'you@example.com',
            icon: 'assets/icons/mail.png',
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            icon: 'assets/icons/lock.png',
            isPassword: true,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
              ),
              child: Text('Forgot password?', style: AppTextStyles.body(14, color: AppColors.primary, weight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Sign In',
            width: double.infinity,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('New to Civicly?', style: AppTextStyles.body(14)),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
                child: Text('Create an account', style: AppTextStyles.body(14, color: AppColors.primary, weight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
