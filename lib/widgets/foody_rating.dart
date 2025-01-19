import 'package:flutter/material.dart';

class FoodyRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final void Function(double rating)? onRatingChanged;
  final Color? color;
  final Color? borderColor;
  final double? size;
  final MainAxisAlignment mainAxisAlignment;
  final bool allowHalfRating;
  final IconData? filledIcon;
  final IconData? halfFilledIcon;
  final IconData? emptyIcon;

  const FoodyRating({
    super.key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.color,
    this.borderColor,
    this.size,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.allowHalfRating = false,
    this.filledIcon,
    this.halfFilledIcon,
    this.emptyIcon,
  });

  Widget buildStar(BuildContext context, int index) {
    IconData iconData;
    if (index >= rating) {
      iconData = emptyIcon ?? Icons.star_border;
    } else if (index > rating - 1 && index < rating) {
      iconData = halfFilledIcon ?? Icons.star_half;
    } else {
      iconData = filledIcon ?? Icons.star;
    }

    Icon icon = Icon(
      iconData,
      color:
          index >= rating ? borderColor ?? Colors.grey : color ?? Colors.yellow,
      size: size,
    );

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      onLongPress: allowHalfRating && onRatingChanged != null
          ? () => onRatingChanged!(index + 0.5)
          : null,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: List.generate(
            starCount,
            (index) => buildStar(context, index),
          ),
        ),
      ),
    );
  }
}
