import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../utils/show_foody_modal_bottom_sheet.dart';

void showOrderActions({
  required BuildContext context,
  void Function()? onMarkAsPreparing,
  void Function()? onMarkAsCompleted,
  void Function()? onViewOrderDishes,
}) {
  showFoodyModalBottomSheet(
    context: context,
    child: Column(
      children: [
        _actionItem(
          label: "Contrassegna come IN PREPARAZIONE",
          icon: PhosphorIconsRegular.chefHat,
          onTap: onMarkAsPreparing,
        ),
        _actionItem(
          label: "Contrassegna come COMPLETATO",
          icon: PhosphorIconsRegular.checkCircle,
          onTap: onMarkAsCompleted,
        ),
        _actionItem(
          label: "Vedi tutti i piatti",
          icon: PhosphorIconsRegular.receipt,
          onTap: onViewOrderDishes,
        ),
      ],
    ),
  );
}

Widget _actionItem({
  required String label,
  required IconData icon,
  void Function()? onTap,
  Color? color,
}) =>
    onTap == null
        ? const SizedBox.shrink()
        : ListTile(
            title: Text(label, style: TextStyle(color: color)),
            leading: Icon(icon, color: color),
            onTap: onTap,
          );
