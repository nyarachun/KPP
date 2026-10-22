import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/civicly_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/event_row_card.dart';
import '../../profile/screens/profile_screen.dart';
import 'create_event_screen.dart';
import 'edit_event_screen.dart';
import 'event_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String _userName = AppConstants.userName;

  void _open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final events = AppConstants.events;

    return Scaffold(
      body: Column(
        children: [
          CivicHeader(
            trailing: HeaderUser(
              name: _userName,
              onProfile: () => _open(context, const ProfileScreen()),
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
                            Text('UPCOMING OPPORTUNITIES', style: AppTextStyles.eyebrow(12)),
                            const SizedBox(height: 12),
                            Text('Events for you', style: AppTextStyles.title(64)),
                            const SizedBox(height: 12),
                            Text('Find a cause, meet your community, and lend a hand.', style: AppTextStyles.body(18)),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 'Add event',
                        width: 220,
                        onPressed: () => _open(context, const CreateEventScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/icons/calendar.png', width: 17),
                          const SizedBox(width: 10),
                          Text(
                            '${events.length} upcoming events',
                            style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (int i = 0; i < events.length; i++)
                    EventRowCard(
                      month: events[i]['month']!,
                      day: events[i]['day']!,
                      title: events[i]['title']!,
                      date: events[i]['date']!,
                      location: events[i]['location']!,
                      onTap: i == 0 ? () => _open(context, const EventDetailsScreen()) : null,
                      onEdit: i == 0 ? () => _open(context, const EditEventScreen()) : null,
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
