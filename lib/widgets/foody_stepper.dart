import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class FoodyStepper extends StatelessWidget {
  const FoodyStepper({
    super.key,
    required this.steps,
    required this.activeStep,
    this.onStepChanged,
    this.lineLength = 40,
  });

  final List<dynamic> steps;
  final int activeStep;
  final void Function(int)? onStepChanged;
  final double lineLength;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      lineStyle: LineStyle(
        defaultLineColor: Colors.grey,
        lineType: LineType.normal,
        finishedLineColor: Theme.of(context).primaryColor,
        lineThickness: 2,
        lineLength: lineLength,
      ),
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      stepRadius: 28,
      disableScroll: true,
      showTitle: false,
      finishedStepBackgroundColor: Theme.of(context).colorScheme.primary,
      defaultStepBorderType: BorderType.normal,
      finishedStepBorderType: BorderType.normal,
      finishedStepBorderColor: Theme.of(context).colorScheme.primary,
      showLoadingAnimation: false,
      fitWidth: true,
      steps: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;

        return EasyStep(
          customStep: child is IconData
              ? Opacity(
                  opacity: activeStep >= index ? 1 : 0.3,
                  child: Icon(
                    child,
                    color: activeStep > index
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                )
              : child,
        );
      }).toList(),
      onStepReached: onStepChanged,
    );
  }
}
