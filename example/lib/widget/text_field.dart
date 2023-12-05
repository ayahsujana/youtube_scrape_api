import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KhmertracksTextField extends StatelessWidget {
  const KhmertracksTextField(
      {super.key,
      this.labelText = '',
      this.labelWidget,
      this.obscureText = false,
      this.enableSuggestions = false,
      this.autocorrect = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.validator,
      this.onFieldSubmitted,
      this.textInputAction,
      this.keyboardType,
      this.readOnly = false,
      this.minLine = 1,
      this.maxLine = 1,
      this.maxLength,
      this.focusNode,
      this.hintText,
      this.initialValue,
      this.autofocus = false,
      this.onTap,
      this.controller,
      this.prefixText,
      this.inputFormatters,
      this.textAlign = TextAlign.start,
      this.floatingLabelBehavior = FloatingLabelBehavior.always,
      this.outlineInputBorder = false});

  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final Widget? labelWidget;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int minLine;
  final int maxLine;
  final bool autofocus;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool outlineInputBorder;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: key,
        initialValue: initialValue,
        controller: controller,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        textAlign: textAlign,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        readOnly: readOnly,
        minLines: minLine,
        maxLength: maxLength,
        autofocus: autofocus,
        focusNode: focusNode,
        maxLines: maxLine,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          border: outlineInputBorder
              ? const OutlineInputBorder(borderSide: BorderSide.none)
              : const UnderlineInputBorder(),
          floatingLabelBehavior: floatingLabelBehavior,
          hintText: hintText,
          labelText: labelText,
          counterText: '',
          suffixIcon: suffixIcon,
          prefixText: prefixText,
          prefixIcon: prefixIcon,
        ),
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted);
  }
}
