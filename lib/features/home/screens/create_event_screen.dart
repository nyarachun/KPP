import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/back_link.dart';
import '../../../core/widgets/civicly_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_text_field.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    FirebaseAnalytics.instance.logEvent(name: 'event_created');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CivicHeader(trailing: HeaderUser()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(48),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 360,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BackLink(),
                        const SizedBox(height: 16),
                        Text('Create event', style: AppTextStyles.title(64).copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text(
                          'Share the essentials so volunteers know how to help.',
                          style: AppTextStyles.body(18).copyWith(height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 64),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: 'Event name',
                              validator: (v) => Validators.required(v, 'Event name'),
                              hint: 'Enter a clear event name',
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Description',
                              validator: (v) => Validators.required(v, 'Description'),
                              rightLabel: '0 / 500 characters',
                              hint: 'Describe the activity, what to bring, and how volunteers will make an impact.',
                              maxLines: 4,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: 'Event date',
                                    validator: (v) => Validators.required(v, 'Date'),
                                    hint: 'Select a date',
                                    icon: 'assets/icons/calendar-grey.png',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomTextField(
                                    label: 'Start time',
                                    validator: (v) => Validators.required(v, 'Start time'),
                                    hint: 'Select time',
                                    icon: 'assets/icons/clock.png',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CustomTextField(
                                    label: 'End time',
                                    validator: (v) => Validators.required(v, 'End time'),
                                    hint: 'Select time',
                                    icon: 'assets/icons/clock.png',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: 'Location',
                              validator: (v) => Validators.required(v, 'Location'),
                              hint: 'Add an address or meeting point',
                              icon: 'assets/icons/location-grey.png',
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomButton(text: 'Save event', icon: 'assets/icons/check.png', onPressed: _save),
                            ),
                          ],
                        ),
                      ),
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
