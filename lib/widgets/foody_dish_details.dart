import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_api_client/dto/request/order_dish_request_dto.dart';
import 'package:foody_api_client/dto/response/dish_response_dto.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_event.dart';
import 'package:foody_business_app/routing/navigation_service.dart';
import 'package:foody_business_app/widgets/foody_button.dart';
import 'package:foody_business_app/widgets/foody_circular_image.dart';
import 'package:foody_business_app/widgets/foody_number_field.dart';
import 'package:foody_business_app/widgets/foody_rating.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DishDetails extends HookWidget {
  const DishDetails({
    super.key,
    required this.dish,
    this.canAddToCart = false,
  });

  final DishResponseDto dish;
  final bool canAddToCart;

  @override
  Widget build(BuildContext context) {
    final quantity = useState(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.center,
          child: FoodyCircularImage(
            defaultWidget: Icon(
              PhosphorIconsRegular.forkKnife,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
            imageUrl: dish.photoUrl,
            showShadow: false,
            size: 150,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                dish.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "${dish.price.toStringAsFixed(2)} €",
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 40),
        Column(
          spacing: 10,
          children: [
            FoodyRating(
              rating: dish.averageRating,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            const Text("Valutazioni lasciate su Foody"),
          ],
        ),
        const Divider(height: 40),
        const Text(
          "Descrizione",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(dish.description),
        if (canAddToCart) ...[
          const Divider(height: 40),
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantità",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        FoodyNumberField(
                          onChanged: (v) => quantity.value = v.toInt(),
                        ),
                      ],
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Totale",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${(dish.price * quantity.value).toStringAsFixed(2)} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FoodyButton(
            label: "Aggiungi al carrello",
            height: 50,
            onPressed: () {
              context.read<OrderFormBloc>().add(AddOrderDish(
                    orderDish: OrderDishRequestDto(
                      dishId: dish.id,
                      quantity: quantity.value,
                    ),
                  ));
              NavigationService().goBack();
            },
          ),
        ],
      ],
    );
  }
}
