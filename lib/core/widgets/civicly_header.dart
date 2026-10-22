import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CivicHeader extends StatelessWidget {
  final Widget? trailing;
  const CivicHeader({super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Image.asset('assets/icons/logo.png', width: 23)),
              ),
              const SizedBox(width: 16),
              Text(
                AppConstants.appName,
                style: AppTextStyles.body(24, color: AppColors.text, weight: FontWeight.w700),
              ),
            ],
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class HeaderUser extends StatelessWidget {
  final String name;
  final VoidCallback? onEvents;
  final VoidCallback? onProfile;

  const HeaderUser({super.key, required this.name, this.onEvents, this.onProfile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onEvents ?? () => Navigator.popUntil(context, (route) => route.isFirst),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('Events', style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 24),
        GestureDetector(
          onTap: onProfile,
          child: Row(
            children: [
              Text(name, style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600)),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.chip,
                child: Image.asset('assets/icons/user.png', width: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
