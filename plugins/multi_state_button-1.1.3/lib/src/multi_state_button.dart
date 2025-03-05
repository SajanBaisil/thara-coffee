import 'package:flutter/material.dart';

import 'package:multi_state_button/multi_state_button.dart';

class MultiStateButton extends StatefulWidget {

  const MultiStateButton({
    required this.buttonStates, required this.multiStateButtonController, Key? key,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.transitionCurve = Curves.easeIn,
  }) : super(key: key);
  /// List of button states.
  /// Note: Default initial State is the first button state.
  /// Can override this behaviour with [initialStateName] constructor parameter of [MultiStateButtonController].
  final List<ButtonState> buttonStates;

  /// Used to change the current state of the button
  final MultiStateButtonController multiStateButtonController;

  /// Transition duration between button state transition.
  /// Defaults to 500 milliseconds
  final Duration transitionDuration;

  /// Transition curve between button state transition.
  /// Defaults to [Curves.easeIn]
  final Curve transitionCurve;

  @override
  _MultiStateButtonState createState() => _MultiStateButtonState();
}

class _MultiStateButtonState extends State<MultiStateButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.transitionDuration);
    _animation =
        CurvedAnimation(parent: _controller, curve: widget.transitionCurve);
    _controller.forward(from: 1);
    widget.multiStateButtonController.buttonStateName.addListener(() {
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.multiStateButtonController.buttonStateName,
      builder: (context, value, child) {
        final currentButtonState = value.isEmpty
            ? widget.buttonStates.first
            : widget.buttonStates
                .firstWhere((element) => element.stateName == value);
        return Material(
          color: currentButtonState.decoration?.color,
          shape: RoundedRectangleBorder(
              borderRadius: currentButtonState.decoration?.borderRadius ??
                  BorderRadius.zero,),
          child: InkWell(
            borderRadius: currentButtonState.decoration?.borderRadius
                ?.resolve(TextDirection.ltr),
            onTap: currentButtonState.onPressed,
            child: Container(
                // decoration: currentButtonState.decoration,
                child: AnimatedContainer(
              width: currentButtonState.size?.width,
              height: currentButtonState.size?.height,
              // color: currentButtonState.decoration == null
              //     ? Colors.transparent
              //     : null,
              decoration: currentButtonState.decoration
                  ?.copyWith(color: Colors.transparent),
              alignment: currentButtonState.alignment,
              duration: widget.transitionDuration,
              curve: widget.transitionCurve,
              clipBehavior: currentButtonState.clipBehavior,
              foregroundDecoration: currentButtonState.foregroundDecoration,
              onEnd: currentButtonState.onAnimationEnd,
              transform: currentButtonState.transform,
              transformAlignment: currentButtonState.transformAlignment,
              child: AnimatedDefaultTextStyle(
                duration: widget.transitionDuration,
                curve: widget.transitionCurve,
                // Default theme's text style uses textStyle with inherit is false. Passing it causeing error. Thus overriding it with inherit as true
                style: currentButtonState.textStyle?.copyWith(inherit: true) ??
                    const TextStyle(fontSize: 12),
                child: FadeTransition(
                  opacity: _animation,
                  child: currentButtonState.child,
                ),
              ),
            ),),
          ),
        );
      },
    );
  }
}
