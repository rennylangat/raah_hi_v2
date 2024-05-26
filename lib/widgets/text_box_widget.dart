import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raah_hi_v2/utils/app_colors.dart';
import 'package:raah_hi_v2/utils/text_style.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool obscureText;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final int maxLines;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final bool isEnabled;
  final bool filled;
  final bool isPassword;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onSubmit;
  final bool isSearch;
  final bool isDropDown;
  final TextCapitalization capitalization;
  final String? errorText;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final Color enableOutlineColor;
  final double borderWidth;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final bool autoFocus;
  final Color prefixIconColor;

  const CustomTextField({
    super.key,
    this.hintText = "Write something...",
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.fillColor = AppColor.textBoxFillColor,
    this.hintColor = AppColor.hintText,
    this.maxLines = 1,
    this.isShowBorder = false,
    this.isIcon = false,
    this.isShowSuffixIcon = false,
    this.isShowPrefixIcon = false,
    this.onTap,
    this.onChanged,
    this.onSuffixTap,
    this.isSearch = false,
    this.isDropDown = false,
    this.capitalization = TextCapitalization.none,
    this.errorText,
    this.borderRadius = 10,
    this.verticalPadding = 14,
    this.horizontalPadding = 22,
    this.enableOutlineColor = AppColor.utilityOutline,
    this.borderWidth = 0.5,
    this.isEnabled = true,
    this.prefixIcon,
    this.filled = true,
    this.isPassword = false,
    this.onSubmit,
    this.validator,
    this.suffixWidget,
    this.autoFocus = false,
    this.prefixIconColor = AppColor.primary,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.inputType,
        textInputAction: widget.textInputAction,
        cursorColor: Theme.of(context).primaryColor,
        autofocus: widget.autoFocus,
        enabled: widget.isEnabled,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: interRegular.copyWith(color: AppColor.textColor, fontSize: 16.0),
        inputFormatters: widget.inputType == TextInputType.phone
            ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))]
            : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.verticalPadding,
            horizontal: widget.horizontalPadding,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: AppColor.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadius),
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: AppColor.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              widget.borderRadius,
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: widget.enableOutlineColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              widget.borderRadius,
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              widget.borderRadius,
            ),
            borderSide: BorderSide(
              width: widget.borderWidth,
              color: Colors.red,
            ),
          ),
          isDense: true,
          hintText: widget.hintText,
          fillColor: widget.fillColor,
          hintStyle: interRegular.copyWith(
            color: widget.hintColor,
            fontSize: 14.0,
          ),
          filled: widget.filled,
          prefixIcon: widget.isShowPrefixIcon
              ? Icon(
                  widget.prefixIcon,
                  color: widget.prefixIconColor,
                  size: 20,
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 30,
            minHeight: 20,
            maxWidth: 40,
          ),
          suffixIcon: widget.isShowSuffixIcon
              ? widget.isPassword
                  ? IconButton(
                      onPressed: _toogle,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.hintText,
                      ),
                    )
                  : widget.isIcon
                      ? IconButton(
                          onPressed: widget.onSuffixTap,
                          icon: Icon(
                            widget.isSearch
                                ? Icons.search_outlined
                                : widget.isDropDown
                                    ? Icons.arrow_drop_down_sharp
                                    : Icons.expand_more,
                            size: 25,
                            color: widget.hintColor,
                          ),
                        )
                      : widget.suffixWidget
              : null,
        ),
        onTap: widget.onTap,
        onFieldSubmitted: (text) => widget.nextFocusNode != null
            ? FocusScope.of(context).requestFocus(widget.focusNode)
            : widget.onSubmit != null
                ? widget.onSubmit!()
                : null,
        onChanged:
            widget.onChanged == null ? null : (text) => widget.onChanged!(text),
      ),
    );
  }

  void _toogle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
