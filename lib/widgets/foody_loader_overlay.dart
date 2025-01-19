import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FoodyLoaderOverlay extends StatelessWidget {
  const FoodyLoaderOverlay({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(opacity: animation, child: child),
      child: isLoading
          ? Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: ColoredBox(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                Lottie.asset(
                  "assets/lottie/loading.json",
                  height: 200,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
