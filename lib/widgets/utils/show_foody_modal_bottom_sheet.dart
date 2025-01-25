import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/widgets/foody_bottom_sheet_layout.dart';

Future<T?> showFoodyModalBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  int? maxHeightPercentage,
  bool draggable = false,
}) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) => FoodyBottomSheetLayout(
        context: context,
        maxHeightPercentage: maxHeightPercentage,
        draggable: draggable,
        child: child,
      ),
    );

Future<T?> showFoodyModalBottomSheetWithBloc<T,
        B extends StateStreamableSource<Object?>>({
  required BuildContext context,
  required Widget child,
  int? maxHeightPercentage,
  bool draggable = false,
  required B Function(BuildContext) createBloc,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return BlocProvider<B>(
          create: (context) => createBloc(context),
          child: FoodyBottomSheetLayout(
            context: context,
            maxHeightPercentage: maxHeightPercentage,
            draggable: draggable,
            child: child,
          ),
        );
      },
    );
