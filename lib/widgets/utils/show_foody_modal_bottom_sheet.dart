import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/widgets/foody_bottom_sheet_layout.dart';

Future<T?> showFoodyModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  int? maxHeightPercentage,
  bool draggable = false,
  double draggableInitialChildSize = 0.6,
}) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => FoodyBottomSheetLayout(
        context: context,
        maxHeightPercentage: maxHeightPercentage,
        draggable: draggable,
        draggableInitialChildSize: draggableInitialChildSize,
        child: child,
      ),
    );

Future<T?> showFoodyModalBottomSheetWithBloc<T,
        B extends StateStreamableSource<Object?>>({
  required BuildContext context,
  required Widget child,
  int? maxHeightPercentage,
  bool draggable = false,
  double draggableInitialChildSize = 0.6,
  required B Function(BuildContext) createBloc,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return BlocProvider<B>(
          create: (context) => createBloc(context),
          child: FoodyBottomSheetLayout(
            context: context,
            maxHeightPercentage: maxHeightPercentage,
            draggable: draggable,
            draggableInitialChildSize: draggableInitialChildSize,
            child: child,
          ),
        );
      },
    );
