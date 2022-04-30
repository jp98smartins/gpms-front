import 'package:flutter/material.dart';

import '../../../core/utils/app_validators.dart';

class DropdownFormFieldApp extends StatelessWidget {
  const DropdownFormFieldApp({
    Key? key,
    required this.value,
    required this.label,
    required this.changeValue,
    required this.items,
  }) : super(key: key);

  final dynamic value;
  final String label;
  final void Function(dynamic)? changeValue;
  final List<DropdownMenuItem<Object>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      key: key,
      value: value,
      validator: (value) => validatorEmpty(value.toString()),
      hint: Text(label),
      items: items,
      onChanged: changeValue,
    );
  }
}
