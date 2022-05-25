import 'package:animation_assignment/resources/dimens.dart';
import 'package:flutter/material.dart';

const kAnimationDuration = 250;

class AnimatedExpandCollapseButtonView extends StatefulWidget {
  final Function onTap;

  AnimatedExpandCollapseButtonView({required this.onTap});

  @override
  State<AnimatedExpandCollapseButtonView> createState() =>
      _AnimatedExpandCollapseButtonViewState();
}

class _AnimatedExpandCollapseButtonViewState
    extends State<AnimatedExpandCollapseButtonView>
    with TickerProviderStateMixin {
  /// State Variable
  var isExpanded = true;

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: kAnimationDuration),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(_controller.view);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: GestureDetector(
        onTap: () {
          _controller.isCompleted
              ? _controller.reverse()
              : _controller.forward();
          widget.onTap();
        },
        child: const Icon(
          Icons.keyboard_arrow_up,
          size: MARGIN_XLARGE,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
