import 'package:flutter/material.dart';
import 'package:foody_business_app/dto/response/order_response_dto.dart';

class AllOrderDishes extends StatelessWidget {
  const AllOrderDishes({super.key, required this.order});

  final OrderResponseDto order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Piatti",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Ordine #${order.id}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ListView.separated(
          itemCount: order.orderDishes.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (_, i) {
            final orderDish = order.orderDishes[i];

            return MediaQuery(
              data: const MediaQueryData(padding: EdgeInsets.zero),
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: orderDish.dishName,
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
                  "${(orderDish.price * orderDish.quantity).toStringAsFixed(2)} €",
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.right,
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        )
      ],
    );
  }
}
