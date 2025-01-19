import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/widgets/foody_empty_data.dart';

import '../../bloc/order_form/order_form_bloc.dart';
import '../../bloc/order_form/order_form_state.dart';
import '../../widgets/foody_dish_card.dart';

class OrderFormDishesStep extends StatelessWidget {
  const OrderFormDishesStep({super.key});

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
                  "Cosa vuoi mangiare?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox.shrink(),
                if (state.dishes.isEmpty)
                  const FoodyEmptyData(
                    title: "Nessun piatto nel menù del ristorante",
                    description: "Ordina direttamente dal personale del locale",
                    lottieAsset: "empty_menu.json",
                    lottieAnimated: false,
                    lottieHeight: 150,
                  )
                else
                  ...state.dishes.map(
                    (dish) => FoodyDishCard(
                      dish: dish,
                      canAddToCart: true,
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
