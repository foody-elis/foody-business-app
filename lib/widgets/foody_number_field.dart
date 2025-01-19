import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class FoodyNumberField extends StatelessWidget {
  const FoodyNumberField({
    super.key,
    this.title,
    this.padding,
    this.margin,
    this.onChanged,
    this.required = false,
    this.startValue = 1,
  });

  final String? title;
  final EdgeInsetsGeometry? padding, margin;
  final void Function(double)? onChanged;
  final bool required;
  final double startValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  if (required)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SpinBox(
              min: 1,
              max: 999,
              value: startValue,
              decoration: const InputDecoration(border: InputBorder.none),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
