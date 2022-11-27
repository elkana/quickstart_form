import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const MyButton(this.label, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
          child:
              MaterialButton(child: label.text.white.make(), onPressed: onTap, minWidth: double.infinity, height: 42.0),
          borderRadius: BorderRadius.circular(10.0),
          elevation: 5.0,
          color: Colors.purple)
      .py16();
}

class MyTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  const MyTextFormField(this.label,
      {Key? key, this.controller, this.onSaved, this.validator, this.suffixIcon, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      validator: validator,
      onSaved: onSaved,
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
          labelText: label, suffixIcon: suffixIcon, contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0)),
      obscureText: obscureText);
}
