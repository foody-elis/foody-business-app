import 'package:flutter/material.dart';
import 'package:foody_business_app/widgets/foody_empty_data.dart';

class OrderFormPayStep extends StatelessWidget {
  const OrderFormPayStep({super.key});

  @override
  Widget build(BuildContext context) {
    return FoodyEmptyData(
      title: "Oggi offriamo noi!",
      description: "Il pagamento è in fase di sviluppo",
      lottieAsset: "order_sales.json",
      lottieHeight: 150,
      containerHeight: MediaQuery.of(context).size.height - 300,
    );
  }
}
