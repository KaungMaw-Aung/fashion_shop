import 'package:animation_assignment/resources/dimens.dart';
import 'package:flutter/material.dart';

const kHalfSecondAnimationDuration = 500;

class AnimatedFavoriteButtonView extends StatefulWidget {
  const AnimatedFavoriteButtonView({Key? key}) : super(key: key);

  @override
  State<AnimatedFavoriteButtonView> createState() =>
      _AnimatedFavoriteButtonViewState();
}

class _AnimatedFavoriteButtonViewState extends State<AnimatedFavoriteButtonView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation _rotationAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: kHalfSecondAnimationDuration),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(_controller.view);

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller.view);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: () => _controller.isCompleted
              ? _controller.reverse()
              : _controller.forward(),
          child: RotationTransition(
            turns: _controller.view,
            child: Icon(
              Icons.favorite,
              size: MARGIN_XLARGE,
              color: _colorAnimation.value,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
