import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/bloc/orders/orders_state.dart';
import 'package:foody_business_app/utils/animation/animated_flip_counter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/orders/orders_bloc.dart';
import '../../bloc/orders/orders_event.dart';
import '../../routing/navigation_service.dart';
import '../../utils/animation/spin.dart';

class OrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrdersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget syncIcon() => IconButton(
          onPressed: () => context.read<OrdersBloc>().add(FetchOrders()),
          icon: const Icon(PhosphorIconsRegular.arrowsClockwise),
        );

    return BlocBuilder<OrdersBloc, OrdersState>(builder: (context, state) {
      return AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceBright,
        // centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            const Icon(PhosphorIconsRegular.chefHat),
            AnimatedFlipCounter(
              prefix: "Totale ordini: ",
              textStyle: const TextStyle(fontSize: 16),
              value: state.orders.length,
              duration: const Duration(milliseconds: 400),
            ),
            const Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text("Ordini"),
                ],
              ),
            ),
          ],
        ),

        automaticallyImplyLeading: false,
        actions: [
          state.isLoading
              ? Spin(
                  duration: const Duration(milliseconds: 1000),
                  infinite: true,
                  curve: Curves.linear,
                  child: syncIcon(),
                )
              : syncIcon(),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Logout"),
                content: const Text(
                  "Sei sicuro di voler uscire dal tuo account Foody?",
                ),
                actions: [
                  TextButton(
                    child: const Text("No"),
                    onPressed: () => NavigationService().goBack(),
                  ),
                  TextButton(
                    child: const Text("Esci"),
                    onPressed: () => context.read<OrdersBloc>().add(Logout()),
                  ),
                ],
              ),
            ),
            icon: const Icon(PhosphorIconsRegular.signOut),
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
