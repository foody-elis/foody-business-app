import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_state.dart';
import 'package:foody_business_app/routing/constants.dart';
import 'package:foody_business_app/screens/order_form/cart_step.dart';
import 'package:foody_business_app/screens/order_form/dishes_step.dart';
import 'package:foody_business_app/screens/order_form/stepper.dart';
import 'package:foody_business_app/screens/order_form/summary_step.dart';
import 'package:foody_business_app/screens/order_form/table_code_step.dart';
import 'package:foody_business_app/utils/show_snackbar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/foody/foody_bloc.dart';
import '../../bloc/foody/foody_event.dart';
import '../../bloc/order_form/order_form_event.dart';
import '../../routing/navigation_service.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderFormBloc, OrderFormState>(
      listener: (context, state) {
        if (state.apiError != "") {
          showSnackBar(context: context, msg: state.apiError);
        }

        context
            .read<FoodyBloc>()
            .add(ShowLoadingOverlayChanged(show: state.isLoading));
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isLoading,
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surfaceBright,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceBright,
              centerTitle: true,
              title: const Text("Ordina"),
              leading: state.activeStep > 0
                  ? IconButton(
                      onPressed: () =>
                          context.read<OrderFormBloc>().add(PreviousStep()),
                      icon: const Icon(PhosphorIconsLight.arrowLeft),
                    )
                  : null,
              actions: [
                if (state.activeStep > 0)
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Annulla ordine"),
                        content: const Text(
                          "Sei sicuro di voler annullare il tuo ordine?",
                        ),
                        actions: [
                          TextButton(
                            child: const Text("No"),
                            onPressed: () => NavigationService().goBack(),
                          ),
                          TextButton(
                            child: const Text("Sì"),
                            onPressed: () => {
                              NavigationService().resetToScreen(orderFormRoute)
                            },
                          ),
                        ],
                      ),
                    ),
                    icon: const Icon(PhosphorIconsLight.x),
                  ),
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
                          onPressed: () =>
                              context.read<OrderFormBloc>().add(Logout()),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(PhosphorIconsRegular.signOut),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  const OrderFormStepper(),
                  Expanded(
                    child: AnimatedSwitcher(
                      layoutBuilder: (currentChild, _) => Align(
                        alignment: Alignment.topCenter,
                        child: currentChild,
                      ),
                      duration: const Duration(milliseconds: 300),
                      child: switch (state.activeStep) {
                        0 => const OrderFormTableCodeStep(),
                        1 => const OrderFormDishesStep(),
                        2 => const OrderFormCartStep(),
                        3 => const OrderFormSummaryStep(),
                        _ => null,
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: state.activeStep != 3
                ? FloatingActionButton(
                    onPressed: switch (state.activeStep) {
                      0 => () =>
                          context.read<OrderFormBloc>().add(TableCodeSubmit()),
                      1 => () => context
                          .read<OrderFormBloc>()
                          .add(OrderDishesSubmit()),
                      2 => () =>
                          context.read<OrderFormBloc>().add(OrderCartSubmit()),
                      3 => () =>
                          context.read<OrderFormBloc>().add(SummarySubmit()),
                      _ => null
                    },
                    child: const Icon(PhosphorIconsRegular.paperPlaneRight),
                  )
                : null,
          ),
        );
      },
    );
  }
}
