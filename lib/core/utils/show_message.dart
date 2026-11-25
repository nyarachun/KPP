import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

void showMessage(BuildContext context, String text, {bool isError = false}) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text), backgroundColor: isError ? AppColors.error : AppColors.success));
}
