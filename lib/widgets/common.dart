import 'package:flutter/material.dart';

class PaddingAll extends StatelessWidget {
  final double gap;
  final Widget? child;
  const PaddingAll({Key? key, this.child, this.gap = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(child: child, padding: EdgeInsets.all(gap));
}

class GapHorizontal extends StatelessWidget {
  const GapHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(width: 20);
}

class GapVertical extends StatelessWidget {
  const GapVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox(height: 20);
}

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const MyButton(this.label, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: MaterialButton(
            child: Text(label, style: const TextStyle(color: Colors.white)),
            onPressed: onTap,
            minWidth: double.infinity,
            height: 42.0),
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
        color: Colors.purple);
  }
}

class MyTextField extends StatelessWidget {
  final String? label;
  final String? value;
  final bool readonly;
  final Color? color;
  final int? maxLength;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool hideFooter;
  InputDecoration? decoration;
  TextEditingController? controller;

  MyTextField(
      {Key? key,
      this.controller,
      this.label,
      this.value,
      this.readonly = true,
      this.color,
      this.maxLength,
      this.maxLines,
      this.style,
      this.keyboardType,
      this.focusNode,
      this.decoration,
      this.textAlign,
      this.hideFooter = false})
      : super(key: key) {
    controller ??= TextEditingController(text: value ?? '-');
    decoration ??= InputDecoration(
        hintText: label,
        hintMaxLines: 1,
        labelText: label,
        labelStyle: TextStyle(color: color),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
        border: readonly ? InputBorder.none : null,
        counterText: hideFooter ? '' : null);
  }

  @override
  Widget build(BuildContext context) => TextField(
        focusNode: focusNode,
        keyboardType: keyboardType ?? TextInputType.text,
        autofocus: !readonly,
        enabled: !readonly,
        autocorrect: false,
        enableSuggestions: false,
        textAlign: textAlign ?? TextAlign.start,
        // style: style ?? TextStyle(color: color, fontSize: ThemeUtil.font_size_textfield),
        decoration: decoration,
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
      );
}
