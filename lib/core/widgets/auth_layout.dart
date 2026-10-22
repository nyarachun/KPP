import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'civicly_header.dart';

class AuthLayout extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final String description;
  final Widget card;
  final double cardWidth;
  final Widget? headerTrailing;

  const AuthLayout({
    super.key,
    this.eyebrow,
    required this.title,
    required this.description,
    required this.card,
    this.cardWidth = 520,
    this.headerTrailing,
  });

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 1000;

    return Scaffold(
      body: Column(
        children: [
          CivicHeader(trailing: headerTrailing),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (wide) ...[
                      SizedBox(
                        width: 520,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (eyebrow != null) ...[
                              Text(eyebrow!.toUpperCase(), style: AppTextStyles.eyebrow(12)),
                              const SizedBox(height: 16),
                            ],
                            Text(title, style: AppTextStyles.title(64)),
                            const SizedBox(height: 24),
                            Text(description, style: AppTextStyles.body(18).copyWith(height: 1.6)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                    ],
                    Flexible(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: cardWidth),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: card,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
