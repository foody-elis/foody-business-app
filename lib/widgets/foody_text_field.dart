import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodyTextField extends HookWidget {
  const FoodyTextField({
    super.key,
    required this.title,
    this.hint,
    this.obscureText = false,
    this.padding,
    this.margin,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.showCursor = true,
    this.readOnly = false,
    this.errorText,
    this.required = false,
    this.textArea = false,
    this.label,
    this.maxLength,
    this.keyboardType,
    this.initialLabel,
  });

  final String title;
  final String? hint;
  final bool obscureText;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool showCursor;
  final bool readOnly;
  final String? errorText;
  final bool required;
  final bool textArea;
  final String? label;
  final String? initialLabel;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController(text: initialLabel);

    useEffect(() {
      if (label != null) textController.text = label!;
      return null;
    }, [label]);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        padding: padding,
        margin: margin,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              margin: const EdgeInsets.only(top: 8),
              width: constraints.maxWidth,
              height: textArea ? 100 : 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                maxLength: maxLength,
                maxLines: textArea ? 5 : 1,
                keyboardType: textArea ? TextInputType.multiline : keyboardType,
                textAlignVertical: suffixIcon != null || errorText != null
                    ? TextAlignVertical.center
                    : null,
                controller: textController,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  contentPadding: EdgeInsets.only(
                      left: 16, right: 16, top: textArea ? 8 : 0),
                  border: InputBorder.none,
                  suffixIcon: errorText == null
                      ? suffixIcon
                      : const Icon(
                          PhosphorIconsRegular.warningCircle,
                          color: Colors.red,
                        ),
                  counterText: "",
                ),
                onTap: onTap,
                onChanged: onChanged,
                showCursor: showCursor,
                readOnly: readOnly,
              ),
            ),
            if (errorText != null)
              Text(
                errorText!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }
}
