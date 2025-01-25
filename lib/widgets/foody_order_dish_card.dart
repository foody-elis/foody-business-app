import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_api_client/dto/request/order_dish_request_dto.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_event.dart';
import 'package:foody_business_app/widgets/utils/show_foody_modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'foody_circular_image.dart';
import 'foody_dish_details.dart';

class FoodyOrderDishCard extends StatelessWidget {
  const FoodyOrderDishCard({
    super.key,
    required this.orderDish,
    required this.dish,
  });

  final OrderDishRequestDto orderDish;
  final DishResponseDto dish;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).primaryColor,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 16, left: 10),
        minVerticalPadding: 10,
        onTap: () => showFoodyModalBottomSheet(
          context: context,
          draggable: true,
          child: BlocProvider<OrderFormBloc>.value(
            value: context.read<OrderFormBloc>(),
            child: DishDetails(dish: dish),
          ),
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
            Text(
              "Quantità: ${orderDish.quantity}",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
        subtitle: Text(
          "${(dish.price * orderDish.quantity).toStringAsFixed(2)} €",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: InkWell(
          onTap: () {
            context.read<OrderFormBloc>().add(RemoveOrderDish(dishId: dish.id));
          },
          child: Icon(
            PhosphorIconsRegular.minusCircle,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
