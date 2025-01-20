import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_event.dart';
import 'package:foody_business_app/bloc/order_form/order_form_state.dart';
import 'package:foody_business_app/widgets/foody_button.dart';

class OrderFormSummaryStep extends HookWidget {
  const OrderFormSummaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final showShadowFixedButton = useState(false);

    useEffect(() {
      void changeShadowFixedButtonState() => showShadowFixedButton.value =
          scrollController.position.maxScrollExtent !=
              scrollController.position.pixels;

      scrollController.addListener(changeShadowFixedButtonState);

      return () =>
          scrollController.removeListener(changeShadowFixedButtonState);
    }, []);

    return BlocBuilder<OrderFormBloc, OrderFormState>(
      builder: (context, state) {
        double totalAmount = 0;

        for (final orderDish in state.orderDishes) {
          totalAmount += orderDish.quantity *
              state.dishes.where((d) => d.id == orderDish.dishId).single.price;
        }

        return Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Conferma il tuo ordine",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text(
                      "Tavolo",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "#${state.tableCode}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const Divider(),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: state.orderDishes.length,
                    itemBuilder: (context, index) {
                      final orderDish = state.orderDishes[index];
                      final dish = state.dishes
                          .where((d) => d.id == orderDish.dishId)
                          .single;

                      return ListTile(
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: dish.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: " x${orderDish.quantity}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        trailing: Text(
                          "${(dish.price * orderDish.quantity).toStringAsFixed(2)} €",
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.right,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: -20,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  boxShadow: showShadowFixedButton.value
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, -2),
                          ),
                        ]
                      : null,
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 20,
                  bottom: 10,
                ),
                child: SafeArea(
                  top: false,
                  child: FoodyButton(
                    label: "Conferma ordine",
                    height: 50,
                    onPressed: () =>
                        context.read<OrderFormBloc>().add(SummarySubmit()),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
