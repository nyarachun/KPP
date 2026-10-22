import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String? icon;
  final String? initialValue;
  final bool isPassword;
  final int maxLines;
  final String? rightLabel;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint = '',
    this.icon,
    this.initialValue,
    this.isPassword = false,
    this.maxLines = 1,
    this.rightLabel,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _hidden = widget.isPassword;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final lines = widget.isPassword ? 1 : widget.maxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.label, style: AppTextStyles.body(14, color: AppColors.text, weight: FontWeight.w600)),
            if (widget.rightLabel != null) Text(widget.rightLabel!, style: AppTextStyles.body(12)),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: widget.initialValue,
          obscureText: _hidden,
          minLines: lines,
          maxLines: lines,
          style: AppTextStyles.body(16, color: AppColors.text),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.body(16, color: AppColors.hint),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            prefixIcon: widget.icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.asset(widget.icon!, width: 18, height: 18),
                  ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _hidden = !_hidden),
                    icon: Icon(
                      _hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 18,
                      color: AppColors.muted,
                    ),
                  )
                : null,
            border: _border(AppColors.border),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
