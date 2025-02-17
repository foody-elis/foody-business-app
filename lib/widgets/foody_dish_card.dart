import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/widgets/foody_rating.dart';
import 'package:foody_business_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'foody_circular_image.dart';
import 'foody_dish_details.dart';

class FoodyDishCard extends StatelessWidget {
  const FoodyDishCard({
    super.key,
    required this.dish,
    this.canAddToCart = false,
  });

  final DishResponseDto dish;
  final bool canAddToCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).primaryColor,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 16, left: 10),
        minVerticalPadding: 10,
        onTap: () => canAddToCart
            ? showFoodyModalBottomSheet(
                context: context,
                draggable: true,
                draggableInitialChildSize: 0.8,
                child: BlocProvider<OrderFormBloc>.value(
                  value: context.read<OrderFormBloc>(),
                  child: DishDetails(dish: dish, canAddToCart: true),
                ),
              )
            : showFoodyModalBottomSheet(
                context: context,
                draggable: true,
                child: DishDetails(dish: dish),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        visualDensity: const VisualDensity(vertical: 3),
        leading: FoodyCircularImage(
          defaultWidget: Icon(
            PhosphorIconsRegular.forkKnife,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
          imageUrl: dish.photoUrl,
          showShadow: false,
          size: 70,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dish.name, overflow: TextOverflow.ellipsis),
            FoodyRating(
              rating: dish.averageRating,
              size: 12,
              mainAxisAlignment: MainAxisAlignment.start,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 10),
          ],
        ),
        subtitle: Text(
          "${dish.price.toStringAsFixed(2)} €",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(PhosphorIconsRegular.dotsThree),
      ),
    );
  }
}
