import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/civicly_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../auth/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _card({required EdgeInsets padding, required Widget child}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CivicHeader(
            trailing: HeaderUser(
              name: AppConstants.userName,
              onEvents: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ACCOUNT SETTINGS', style: AppTextStyles.eyebrow(12)),
                            const SizedBox(height: 12),
                            Text('My Profile', style: AppTextStyles.title(64)),
                            const SizedBox(height: 12),
                            Text('Keep your organizer details and account security up to date.', style: AppTextStyles.body(18)),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 'Log out',
                        color: Colors.white,
                        textColor: AppColors.text,
                        borderColor: AppColors.border,
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _card(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 280,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 84,
                                    backgroundColor: AppColors.chip,
                                    child: Image.asset('assets/icons/user.png', width: 64),
                                  ),
                                  Positioned(
                                    right: 4,
                                    bottom: 4,
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: AppColors.primary,
                                      child: Image.asset('assets/icons/camera.png', width: 19),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(AppConstants.userName, style: AppTextStyles.body(24, color: AppColors.text, weight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text(AppConstants.userRole, style: AppTextStyles.body(14)),
                              const SizedBox(height: 20),
                              Text(
                                'Upload a clear JPG or PNG, up to 5 MB.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.body(13),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        Container(width: 1, height: 240, color: AppColors.border),
                        const SizedBox(width: 24),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Personal information', style: AppTextStyles.body(20, color: AppColors.text, weight: FontWeight.w700)),
                              const SizedBox(height: 6),
                              Text('This information appears to volunteers on events you organize.', style: AppTextStyles.body(13)),
                              const SizedBox(height: 16),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: CustomTextField(label: 'First name', initialValue: 'Alex')),
                                  SizedBox(width: 16),
                                  Expanded(child: CustomTextField(label: 'Last name', initialValue: 'Morgan')),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'Email address',
                                      icon: 'assets/icons/mail.png',
                                      initialValue: AppConstants.userEmail,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: CustomTextField(
                                      label: 'Phone number',
                                      icon: 'assets/icons/phone.png',
                                      initialValue: AppConstants.userPhone,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.centerRight,
                                child: CustomButton(
                                  text: 'Save changes',
                                  icon: 'assets/icons/check.png',
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  _card(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Security', style: AppTextStyles.body(20, color: AppColors.text, weight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Choose a strong password you do not use elsewhere.', style: AppTextStyles.body(13)),
                        const SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Expanded(
                              child: CustomTextField(
                                label: 'Current password',
                                icon: 'assets/icons/lock.png',
                                initialValue: '1234567890',
                                isPassword: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: CustomTextField(
                                label: 'New password',
                                hint: 'At least 8 characters',
                                icon: 'assets/icons/key.png',
                                isPassword: true,
                              ),
                            ),
                            const SizedBox(width: 16),
                            CustomButton(text: 'Change password', onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
