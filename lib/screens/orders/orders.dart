import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:foody_business_app/bloc/orders/orders_bloc.dart';
import 'package:foody_business_app/bloc/orders/orders_state.dart';
import 'package:foody_business_app/dto/response/order_response_dto.dart';
import 'package:foody_business_app/screens/orders/app_bar.dart';
import 'package:foody_business_app/utils/animation/fade_in_right.dart';
import 'package:foody_business_app/utils/order_status.dart';
import 'package:foody_business_app/widgets/foody_card_order.dart';
import 'package:foody_business_app/widgets/foody_empty_data.dart';

import '../../bloc/orders/orders_event.dart';
import '../../utils/show_snackbar.dart';

class Orders extends HookWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);

      return () => SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
    }, []);

    undoDismiss(OrderResponseDto order) =>
        context.read<OrdersBloc>().add(UndoDismiss(order: order));

    markAsCompleted(int index) =>
        context.read<OrdersBloc>().add(MarkOrderAsCompleted(
              orderId: index,
              fromDismiss: true,
            ));

    return BlocConsumer<OrdersBloc, OrdersState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: const OrdersAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: state.orders.isEmpty
                  ? const FoodyEmptyData(
                      title: "Nessun ordine al momento",
                      description: "In attesa di nuovi ordini...",
                      lottieAsset: "empty_orders.json",
                      containerHeight: 300,
                      spacing: 0,
                      lottieHeight: 150,
                      lottieWidth: 300,
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.orders.length,
                      itemBuilder: (context, i) {
                        final order = state.orders.reversed.elementAt(i);

                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Dismissible(
                            key: Key(order.id.toString()),
                            direction: order.status == OrderStatus.PREPARING
                                ? DismissDirection.vertical
                                : DismissDirection.none,
                            confirmDismiss: (_) async {
                              bool undo = false;

                              context.read<OrdersBloc>().add(Dismiss(
                                    order: order,
                                    index: state.orders.length - i - 1,
                                  ));

                              showSnackBar(
                                context: context,
                                msg:
                                    "Ordine #${order.id} contrassegnato come completato",
                                duration: const Duration(milliseconds: 1500),
                                action: SnackBarAction(
                                  label: 'Cancella',
                                  onPressed: () {
                                    undo = true;
                                    undoDismiss(order);
                                  },
                                ),
                              );

                              await Future.delayed(const Duration(seconds: 2));

                              if (!undo) markAsCompleted(order.id);

                              return !undo;
                            },
                            child: FadeInRight(
                              child: FoodyOrderCard(order: order),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
