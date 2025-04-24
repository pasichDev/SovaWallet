import 'package:flutter/material.dart';
import 'package:sovawallet/ui/theme/decoration/standart_gradient_decoration.dart';

class HomeGradientDecorationRound extends HomeGradientDecoration {
  const HomeGradientDecorationRound()
      : super(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        );
}
