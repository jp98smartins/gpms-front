import 'package:flutter/material.dart';

class DropdownFormFieldApp extends StatelessWidget {
  const DropdownFormFieldApp({
    Key? key,
    required this.value,
    required this.label,
    required this.changeValue,
    required this.items,
    required this.validator,
  }) : super(key: key);

  final dynamic value;
  final String label;
  final void Function(dynamic)? changeValue;
  final List<DropdownMenuItem<Object>> items;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      key: key,
      value: value,
      validator: validator,
      hint: Text(label),
      items: items,
      onChanged: changeValue,
    );
  }
}
