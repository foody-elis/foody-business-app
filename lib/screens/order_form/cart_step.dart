import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_event.dart';
import 'package:foody_business_app/widgets/foody_empty_data.dart';
import 'package:foody_business_app/widgets/foody_order_dish_card.dart';

import '../../bloc/order_form/order_form_bloc.dart';
import '../../bloc/order_form/order_form_state.dart';

class OrderFormCartStep extends StatelessWidget {
  const OrderFormCartStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormBloc, OrderFormState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                const Text(
                  "Piatti nel carrello",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox.shrink(),
                if (state.orderDishes.isEmpty)
                  const FoodyEmptyData(
                    title: "Nessun piatto nel carrello",
                    description: "Insersci almeno un piatto per poter ordinare",
                    lottieAsset: "empty_cart.json",
                  )
                else
                  ...state.orderDishes.map(
                    (orderDish) => Dismissible(
                      key: ValueKey(orderDish.dishId),
                      onDismissed: (_) =>
                          context.read<OrderFormBloc>().add(RemoveOrderDish(
                                dishId: orderDish.dishId,
                                removeAllQty: true,
                              )),
                      child: FoodyOrderDishCard(
                        orderDish: orderDish,
                        dish: state.dishes
                            .where((d) => orderDish.dishId == d.id)
                            .first,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
