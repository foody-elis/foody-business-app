import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../bloc/foody/foody_bloc.dart';
import '../bloc/foody/foody_event.dart';
import '../bloc/sign_in/sign_in_bloc.dart';
import '../bloc/sign_in/sign_in_event.dart';
import '../bloc/sign_in/sign_in_state.dart';
import '../utils/show_snackbar.dart';
import '../widgets/foody_button.dart';
import '../widgets/foody_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
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
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Lottie.asset(
                      "assets/lottie/sign_in.json",
                      repeat: false,
                      width: 400,
                      // height: 300,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FoodyTextField(
                        required: true,
                        title: 'Email',
                        hint: 'tuaemail@email.com',
                        suffixIcon: const Icon(PhosphorIconsRegular.at),
                        onChanged: (email) => context
                            .read<SignInBloc>()
                            .add(EmailChanged(email: email.trim())),
                        errorText: state.emailError,
                      ),
                      FoodyTextField(
                        required: true,
                        title: 'Password',
                        hint: '**********',
                        obscureText: true,
                        margin: const EdgeInsets.only(top: 16, bottom: 20),
                        suffixIcon: const Icon(PhosphorIconsRegular.lockKey),
                        onChanged: (password) => context
                            .read<SignInBloc>()
                            .add(PasswordChanged(password: password)),
                        errorText: state.passwordError,
                      ),
                      FoodyButton(
                        label: 'Accedi',
                        width: MediaQuery.of(context).size.width,
                        onPressed: () =>
                            context.read<SignInBloc>().add(LoginSubmit()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
