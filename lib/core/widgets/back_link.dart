import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class BackLink extends StatelessWidget {
  const BackLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/arrow_left.png', width: 17, color: AppColors.primary),
          const SizedBox(width: 8),
          Text('Back to events', style: AppTextStyles.body(14, color: AppColors.primary, weight: FontWeight.w600)),
        ],
      ),
    );
  }
}
