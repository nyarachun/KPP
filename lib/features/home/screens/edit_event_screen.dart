import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/back_link.dart';
import '../../../core/widgets/civicly_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';

class EditEventScreen extends StatelessWidget {
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CivicHeader(trailing: HeaderUser(name: AppConstants.userName)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackLink(),
                  const SizedBox(height: 20),
                  Text('Riverside Cleanup', style: AppTextStyles.title(64)),
                  const SizedBox(height: 16),
                  Text('Update the details volunteers will see.', style: AppTextStyles.body(18)),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 760,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextField(label: 'Event name', initialValue: 'Riverside Cleanup'),
                            const SizedBox(height: 16),
                            const CustomTextField(
                              label: 'Description',
                              maxLines: 3,
                              initialValue:
                                  'Help restore the Eastbank River Trail by collecting litter, sorting recyclables, and preparing native planting beds. Supplies and a light lunch are provided.',
                            ),
                            const SizedBox(height: 16),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: 'Event date',
                                    icon: 'assets/icons/calendar-grey.png',
                                    initialValue: 'Saturday, October 5',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CustomTextField(
                                    label: 'Start time',
                                    icon: 'assets/icons/clock.png',
                                    initialValue: '9:00 AM',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CustomTextField(
                                    label: 'End time',
                                    icon: 'assets/icons/clock.png',
                                    initialValue: '12:00 PM',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const CustomTextField(
                              label: 'Location',
                              icon: 'assets/icons/location-grey.png',
                              initialValue: 'Eastbank River Trail — meet at the boathouse',
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Save changes',
                              icon: 'assets/icons/check.png',
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Container(
                        width: 360,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Delete this event', style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            Text(
                              'This permanently removes the event, tasks, and volunteer assignments.',
                              style: AppTextStyles.body(13).copyWith(height: 1.5),
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Delete event',
                              icon: 'assets/icons/trash.png',
                              color: const Color(0xFFFCEAEA),
                              textColor: const Color(0xFFC63C3C),
                              borderColor: const Color(0xFFC63C3C),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ],
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
