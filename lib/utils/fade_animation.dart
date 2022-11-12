import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      // ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AniProps.translateY, Tween(begin: 0.0, end: -45.0),
          Duration(milliseconds: 800), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (200 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Transform.translate(
          offset: Offset(0, animation.get(AniProps.translateY)), child: child),
    );
  }
}
/*   
Opacity{
        opacity: animation.get(AniProps.opacity),
}
 */