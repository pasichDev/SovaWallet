import 'package:flutter/material.dart';
import 'package:sovawallet/ui/theme/decoration/gvt/gvt_gradient_decoration.dart';

class GvtGradientDecorationRound extends GvtGradientDecoration {
  const GvtGradientDecorationRound()
      : super(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        );
}
