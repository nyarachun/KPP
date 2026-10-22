import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EventRowCard extends StatelessWidget {
  final String month;
  final String day;
  final String title;
  final String date;
  final String location;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const EventRowCard({
    super.key,
    required this.month,
    required this.day,
    required this.title,
    required this.date,
    required this.location,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              child: Column(
                children: [
                  Text(month, style: AppTextStyles.eyebrow(11)),
                  Text(day, style: AppTextStyles.body(24, color: AppColors.text, weight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.title(24)),
                  const SizedBox(height: 4),
                  Text(date, style: AppTextStyles.body(15)),
                ],
              ),
            ),
            SizedBox(
              width: 380,
              child: Row(
                children: [
                  Image.asset('assets/icons/location.png', width: 17),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(location, style: AppTextStyles.body(15, color: AppColors.text, weight: FontWeight.w500)),
                  ),
                  if (onEdit != null)
                    GestureDetector(
                      onTap: onEdit,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('EDIT EVENT', style: AppTextStyles.eyebrow(12)),
                      ),
                    ),
                  Image.asset('assets/icons/chevron-right.png', width: 17),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
