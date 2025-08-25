import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voltspot/core/constants/app_colors.dart';
import 'package:voltspot/core/extensions/theme_extensions/text_theme_extension.dart';

class AppTextField extends StatefulWidget {
  final double? height;
  final Function(String? value)? onSaved;
  final FocusNode? focusNode;
  final Function(String value)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final ToolbarOptions? toolbarOptions;
  final TextStyle? style;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final String? Function(String? value)? validator;
  final String? initialValue;
  final bool? expands;
  final bool? readOnly;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final String? errorText;
  final BorderRadius? borderRadius;
  final String? labelText;
  final bool password;
  final Color? fillColor;

  const AppTextField(
      {Key? key,
      this.height,
      this.onSaved,
      this.focusNode,
      this.onChanged,
      this.keyboardType,
      this.maxLength,
      this.maxLines,
      this.textInputAction,
      this.toolbarOptions,
      this.style,
      this.contentPadding,
      this.hintText,
      this.hintStyle,
      this.enabledBorder,
      this.focusedBorder,
      this.controller,
      this.validator,
      this.initialValue,
      this.expands,
      this.readOnly,
      this.inputFormatters,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.errorText,
      this.borderRadius,
      this.labelText,
      this.password = false,
      this.fillColor})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool password;

  @override
  void initState() {
    password = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null)
          Row(
            children: [
              Text(
                widget.labelText!,
                style: context.f14500?.copyWith(color: AppColors.white1),
              ),
            ],
          ),
        if (widget.labelText != null) const SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: TextFormField(
            obscureText: password,
            onSaved: widget.onSaved,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            maxLines: password ? 1 : widget.maxLines,
            toolbarOptions: widget.toolbarOptions,
            textInputAction: widget.textInputAction,
            style:
                widget.style ?? context.f16600?.copyWith(color: Colors.black),
            controller: widget.controller,
            validator: widget.validator,
            initialValue: widget.initialValue,
            expands: widget.expands ?? false,
            readOnly: widget.readOnly ?? false,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              errorText: widget.errorText,
              errorStyle: context.f16600?.copyWith(color: Colors.redAccent),
              fillColor: widget.fillColor ?? Colors.white,
              filled: true,
              suffixIcon: widget.password
                  ? IconButton(
                      icon: Icon(
                        password ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          password = !password;
                        });
                      },
                    )
                  : widget.suffixIcon,
              isDense: false,
              counter: const SizedBox(),
              labelStyle: context.f16600
                  ?.copyWith(color: Colors.black.withOpacity(0.25)),
              floatingLabelStyle: context.f18700
                  ?.copyWith(color: Colors.black, letterSpacing: 1.2),
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  context.f12400
                      ?.copyWith(color: Colors.black.withOpacity(0.25)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.redAccent),
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(10.0)),
              enabledBorder: widget.enabledBorder ??
                  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.fillColor ?? const Color(0xFFE0E0DF)),
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10.0)),
              focusedBorder: widget.focusedBorder ??
                  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.fillColor ?? const Color(0xFFE0E0DF)),
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
