import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_bloc.dart';
import 'package:foody_business_app/bloc/order_form/order_form_event.dart';
import 'package:foody_business_app/bloc/order_form/order_form_state.dart';
import 'package:foody_business_app/widgets/foody_text_field.dart';
import 'package:lottie/lottie.dart';

class OrderFormTableCodeStep extends StatelessWidget {
  const OrderFormTableCodeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          "assets/lottie/table_code.json",
          height: 250,
          // fit: BoxFit.fill,
        ),
        BlocBuilder<OrderFormBloc, OrderFormState>(
          builder: (context, state) {
            return FoodyTextField(
              required: true,
              title: 'Numero del tavolo',
              onChanged: (tableCode) => context.read<OrderFormBloc>().add(
                  TableCodeChanged(tableCode: tableCode.toUpperCase().trim())),
              errorText: state.tableCodeError,
              maxLength: 10,
              label: state.tableCode,
            );
          },
        ),
      ],
    );
  }
}
