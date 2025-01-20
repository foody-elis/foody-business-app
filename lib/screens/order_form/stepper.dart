import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_state.dart';
import 'package:foody_business_app/widgets/foody_stepper.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/order_form/order_form_event.dart';

class OrderFormStepper extends StatelessWidget {
  const OrderFormStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormBloc, OrderFormState>(
      builder: (context, state) {
        return FoodyStepper(
          // lineLength: 20,
          steps: [
            PhosphorIconsRegular.picnicTable,
            PhosphorIconsRegular.forkKnife,
            Opacity(
              opacity: state.activeStep >= 1 ? 1 : 0.3,
              child: Badge(
                badgeContent: Text(
                  state.orderDishes.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                badgeStyle: BadgeStyle(
                  badgeColor: Theme.of(context).primaryColor,
                ),
                badgeAnimation: const BadgeAnimation.slide(
                  animationDuration: Duration(milliseconds: 800),
                ),
                showBadge:
                    state.orderDishes.isNotEmpty && state.activeStep <= 2,
                child: Icon(
                  PhosphorIconsRegular.shoppingCartSimple,
                  color: state.activeStep > 2
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
            PhosphorIconsRegular.receipt,
          ],
          activeStep: state.activeStep,
          onStepChanged: (index) {
            if (index < state.activeStep ||
                state.activeStep == 1 && index == 2) {
              context.read<OrderFormBloc>().add(StepChanged(step: index));
            }
          },
        );
      },
    );
  }
}
