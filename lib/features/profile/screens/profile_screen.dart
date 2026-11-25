import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/show_message.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/civicly_header.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../auth/data/auth_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _repository = AuthRepository.instance;

  final _profileFormKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: _repository.currentUser?.displayName);
  late String? _photoUrl = _repository.currentUser?.photoURL;
  bool _isSaving = false;

  final _passwordFormKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isChangingPassword = false;

  Future<void> _saveProfile() async {
    if (!_profileFormKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      await _repository.updateProfile(name: _nameController.text.trim(), photoUrl: _photoUrl);
      if (mounted) showMessage(context, 'Profile saved.');
    } catch (e) {
      if (mounted) showMessage(context, AuthRepository.errorMessage(e), isError: true);
    }
    if (mounted) setState(() => _isSaving = false);
  }

  Future<void> _changePassword() async {
    if (!_passwordFormKey.currentState!.validate()) return;
    setState(() => _isChangingPassword = true);
    try {
      await _repository.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      _currentPasswordController.clear();
      _newPasswordController.clear();
      if (mounted) showMessage(context, 'Password changed.');
    } catch (e) {
      if (mounted) showMessage(context, AuthRepository.errorMessage(e), isError: true);
    }
    if (mounted) setState(() => _isChangingPassword = false);
  }

  Future<void> _signOut() async {
    await _repository.signOut();
    if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
  }

  Future<void> _pickPhoto() async {
    final url = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose a photo'),
        children: [
          Wrap(
            children: [
              for (final url in AppConstants.avatars)
                IconButton(
                  onPressed: () => Navigator.pop(context, url),
                  icon: Avatar(url: url, radius: 32),
                ),
            ],
          ),
        ],
      ),
    );
    if (url != null) setState(() => _photoUrl = url);
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
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
    final user = _repository.currentUser;

    return Scaffold(
      body: Column(
        children: [
          CivicHeader(trailing: HeaderUser(onEvents: () => Navigator.pop(context))),
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
                            Text(
                              'Keep your organizer details and account security up to date.',
                              style: AppTextStyles.body(18),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 'Log out',
                        color: Colors.white,
                        textColor: AppColors.text,
                        borderColor: AppColors.border,
                        onPressed: _signOut,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  _card(
                    child: Form(
                      key: _profileFormKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Avatar(url: _photoUrl, radius: 84),
                              const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: _pickPhoto,
                                icon: Image.asset('assets/icons/camera.png', width: 18, color: AppColors.primary),
                                label: Text(
                                  'Change photo',
                                  style: AppTextStyles.body(14, color: AppColors.primary, weight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal information',
                                  style: AppTextStyles.body(20, color: AppColors.text, weight: FontWeight.w700),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  label: 'Name',
                                  controller: _nameController,
                                  validator: (v) => Validators.required(v, 'Name'),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  label: 'Email address',
                                  icon: 'assets/icons/mail.png',
                                  initialValue: user?.email,
                                  enabled: false,
                                ),
                                const SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomButton(
                                    text: 'Save changes',
                                    icon: 'assets/icons/check.png',
                                    isLoading: _isSaving,
                                    onPressed: _saveProfile,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _card(
                    child: Form(
                      key: _passwordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Security',
                            style: AppTextStyles.body(20, color: AppColors.text, weight: FontWeight.w700),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: 'Current password',
                                  icon: 'assets/icons/lock.png',
                                  isPassword: true,
                                  controller: _currentPasswordController,
                                  validator: (v) => Validators.required(v, 'Current password'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomTextField(
                                  label: 'New password',
                                  hint: 'At least 8 characters',
                                  icon: 'assets/icons/key.png',
                                  isPassword: true,
                                  controller: _newPasswordController,
                                  validator: Validators.password,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CustomTextField(
                                  label: 'Confirm new password',
                                  icon: 'assets/icons/key.png',
                                  isPassword: true,
                                  validator: (v) => v != _newPasswordController.text ? 'Passwords do not match' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton(
                              text: 'Change password',
                              isLoading: _isChangingPassword,
                              onPressed: _changePassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () async {
                        // Firebase Crashlytics does not support Web, so a handled (non-fatal) error goes to Sentry.
                        try {
                          throw Exception('Test error from Civicly');
                        } catch (error, stackTrace) {
                          await Sentry.captureException(error, stackTrace: stackTrace);
                        }
                        if (context.mounted) showMessage(context, 'Test error sent to Sentry.');
                      },
                      child: Text('Send test error to Sentry', style: AppTextStyles.body(13)),
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
