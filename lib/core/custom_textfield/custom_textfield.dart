import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../colors/app_colors.dart";

typedef Validator = String? Function(String?);
typedef OnChanged = void Function(String);
typedef OnFieldSubmitted = void Function(String);

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.controller,
      required this.onChanged,
      required this.focusNode,
      required this.hintText,
      super.key,
      this.validator,
      this.textInputType = TextInputType.name,
      this.textCapitalization = TextCapitalization.none,
      this.cursorColor = Colors.black,
      this.enabled = true,
      this.obscure = false,
      this.textInputFormatter,
      this.textInputAction = TextInputAction.done,
      this.nextFocusNode,
      this.errorText,
      this.suffix,
      this.suffixIcon,
      this.prefix,
      this.prefixIcon,
      this.prefixTextStyle,
      this.suffixTextStyle,
      this.prefixText,
      this.suffixText,
      this.labelTextStyle,
      this.labelText,
      this.labelInTextField = false,
      this.contentPadding,
      this.cursorHeight,
      this.onFieldSubmitted,
      required this.focusedBorder,
      required this.enabledBorder,
        required this.errorBorder,

        this.isEnabled = true,
      this.hintStyle});

  final TextEditingController controller;
  final Validator? validator;
  final OnChanged onChanged;
  final TextInputType textInputType;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextCapitalization textCapitalization;
  final Color? cursorColor;
  final bool enabled;
  final bool obscure;
  final TextInputFormatter? textInputFormatter;
  final TextInputAction textInputAction;
  final String hintText;
  final String? errorText;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final TextStyle? prefixTextStyle;
  final TextStyle? suffixTextStyle;
  final TextStyle? labelTextStyle;
  final String? labelText;
  final String? prefixText;
  final String? suffixText;
  final bool labelInTextField;
  final EdgeInsetsGeometry? contentPadding;
  final double? cursorHeight;
  final OnFieldSubmitted? onFieldSubmitted;
  final InputBorder focusedBorder;
  final InputBorder enabledBorder;
  final InputBorder errorBorder;

  final bool isEnabled;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (labelText != null && !labelInTextField)
            Text(
              labelText!,
              style: labelTextStyle,
            ),
          if (labelText != null && !labelInTextField)
            SizedBox(
              height: 6,
            ),
          TextFormField(
            key: key,
           // autovalidateMode: AutovalidateMode.onUserInteraction,
            style:
                TextStyle(color: AppColors.activeTestButton.withOpacity(0.8)),
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            keyboardType: textInputType,
            focusNode: focusNode,
            textCapitalization: textCapitalization,
            cursorColor: cursorColor ?? Colors.black,
            enableInteractiveSelection: true,
            obscureText: obscure,
            enabled: enabled,
            textInputAction: textInputAction,
            onEditingComplete: () {
              if (nextFocusNode != null) {
                nextFocusNode?.requestFocus();
              } else {
                focusNode.unfocus();
              }
            },
            onFieldSubmitted: (String value) {
              if (onFieldSubmitted != null) {
                onFieldSubmitted?.call(value);
              }
              if (nextFocusNode != null) {
                nextFocusNode?.requestFocus();
              } else {
                focusNode.unfocus();
              }
            },
            inputFormatters: textInputFormatter != null
                ? <TextInputFormatter>[textInputFormatter!]
                : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabled: isEnabled,
              labelText: labelInTextField ? labelText : null,
              labelStyle: labelTextStyle,
              hintText: hintText,
              hintStyle: hintStyle ??
                  TextStyle(color: AppColors.activeTestButton.withOpacity(0.8)),
              errorText: errorText,
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              suffix: suffix,
              suffixIcon: suffixIcon,
              prefix: prefix,
              prefixIcon: prefixIcon,
              prefixText: prefixText,
              prefixStyle: prefixTextStyle,
              suffixText: suffixText,
              suffixStyle: suffixTextStyle,
              focusedBorder: focusedBorder,
              fillColor: AppColors.baseGrayScale.withOpacity(0.5),
              filled: true,
              enabledBorder: enabledBorder,
              errorBorder: errorBorder,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue
                ),
              ),
            ),
            maxLines: 1,
            cursorHeight: cursorHeight,
          ),

        ],
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty<TextEditingController>("controller", controller))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry?>(
          "contentPadding", contentPadding))
      ..add(ObjectFlagProperty<Validator?>.has("validator", validator))
      ..add(ObjectFlagProperty<OnChanged>.has("onChanged", onChanged))
      ..add(DiagnosticsProperty<TextInputType>("textInputType", textInputType))
      ..add(DiagnosticsProperty<FocusNode>("focusNode", focusNode))
      ..add(DiagnosticsProperty<FocusNode?>("nextFocusNode", nextFocusNode))
      ..add(EnumProperty<TextCapitalization>(
          "textCapitalization", textCapitalization))
      ..add(ColorProperty("cursorColor", cursorColor))
      ..add(DiagnosticsProperty<bool>("enabled", enabled))
      ..add(DiagnosticsProperty<bool>("obscure", obscure))
      ..add(DiagnosticsProperty<TextInputFormatter?>(
          "textInputFormatter", textInputFormatter))
      ..add(EnumProperty<TextInputAction>("textInputAction", textInputAction))
      ..add(StringProperty("hintText", hintText))
      ..add(StringProperty("errorText", errorText))
      ..add(DiagnosticsProperty<TextStyle?>("prefixTextStyle", prefixTextStyle))
      ..add(DiagnosticsProperty<TextStyle?>("suffixTextStyle", suffixTextStyle))
      ..add(DiagnosticsProperty<TextStyle?>("labelTextStyle", labelTextStyle))
      ..add(StringProperty("labelText", labelText))
      ..add(StringProperty("prefixText", prefixText))
      ..add(StringProperty("suffixText", suffixText))
      ..add(DiagnosticsProperty<bool>("labelInTextField", labelInTextField))
      ..add(DoubleProperty("cursorHeight", cursorHeight))
      ..add(ObjectFlagProperty<OnFieldSubmitted?>.has(
          "onFieldSubmitted", onFieldSubmitted));
  }
}
