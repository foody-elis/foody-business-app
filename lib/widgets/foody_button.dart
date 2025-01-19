import 'package:flutter/material.dart';

class FoodyButton extends StatelessWidget {
  const FoodyButton({
    super.key,
    required this.label,
    this.height = 60,
    this.width,
    this.onPressed,
    this.color,
    this.labelFontSize = 16,
    this.radius = 10,
  });

  final String label;
  final double height;
  final double? width;
  final void Function()? onPressed;
  final Color? color;
  final double labelFontSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPressed?.call();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: color ?? Theme.of(context).primaryColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelFontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
