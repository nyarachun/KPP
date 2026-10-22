import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/back_link.dart';
import '../../../core/widgets/civicly_header.dart';
import '../../../core/widgets/custom_button.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  static const List<Map<String, String>> _participants = [
    {'name': 'Alex Morgan', 'email': 'alex.morgan@example.com', 'joined': 'Joined Sep 25', 'role': 'Event organizer'},
    {'name': 'Jordan Lee', 'email': 'jordan.lee@example.com', 'joined': 'Joined Sep 19', 'role': 'Photographer'},
    {'name': 'Priya Shah', 'email': 'priya.shah@example.com', 'joined': 'Joined Sep 21', 'role': 'Loader'},
    {'name': 'Sam Rivera', 'email': 'sam.rivera@example.com', 'joined': 'Joined Sep 22', 'role': 'Driver'},
    {'name': 'Evelyn Brooks', 'email': 'evelyn.b@example.com', 'joined': 'Joined Sep 24', 'role': 'Loader'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CivicHeader(trailing: HeaderUser(name: AppConstants.userName)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(56, 20, 56, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(alignment: Alignment.centerLeft, child: BackLink()),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('COMMUNITY ENVIRONMENT', style: AppTextStyles.eyebrow(11)),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Riverside Cleanup',
                                    style: AppTextStyles.title(48).copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            CustomButton(text: 'Leave Event', onPressed: () => Navigator.pop(context)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Help restore the Eastbank River Trail by collecting litter, sorting recyclables, and preparing native planting beds. Supplies and a light lunch are provided.',
                          style: AppTextStyles.body(16).copyWith(height: 1.6),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(
                              child: _MetaItem(
                                icon: 'assets/icons/calendar.png',
                                title: 'Saturday, October 5',
                                subtitle: '9:00 AM–12:00 PM',
                              ),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: _MetaItem(
                                icon: 'assets/icons/location.png',
                                title: 'Eastbank River Trail',
                                subtitle: 'Meet at the boathouse',
                              ),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: _MetaItem(
                                icon: 'assets/icons/user.png',
                                title: AppConstants.userName,
                                subtitle: 'Event organizer',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: AppColors.background,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Volunteer management',
                                style: AppTextStyles.title(24).copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text('Assign event-day roles. You can update only your own role.', style: AppTextStyles.body(14)),
                            ],
                          ),
                        ),
                        for (int i = 0; i < _participants.length; i++)
                          _ParticipantRow(
                            name: _participants[i]['name']!,
                            email: _participants[i]['email']!,
                            joined: _participants[i]['joined']!,
                            role: _participants[i]['role']!,
                            isMe: i == 0,
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

class _MetaItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  const _MetaItem({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.chip,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: Image.asset(icon, width: 17)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.body(13, color: AppColors.text, weight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.body(13)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ParticipantRow extends StatelessWidget {
  final String name;
  final String email;
  final String joined;
  final String role;
  final bool isMe;

  const _ParticipantRow({
    required this.name,
    required this.email,
    required this.joined,
    required this.role,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.chip,
            child: Image.asset('assets/icons/user.png', width: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(email, style: AppTextStyles.body(13)),
              ],
            ),
          ),
          SizedBox(width: 90, child: Text(joined, style: AppTextStyles.body(13))),
          const SizedBox(width: 16),
          SizedBox(
            width: 180,
            child: isMe
                ? Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(role, style: AppTextStyles.body(13, color: AppColors.text, weight: FontWeight.w600)),
                        const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.muted),
                      ],
                    ),
                  )
                : Text(role, style: AppTextStyles.body(13, color: AppColors.text, weight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
