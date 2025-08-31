import 'package:flutter/material.dart';

Color get primary => const Color(0xffC35BD1);
Color get focus => const Color(0xffD9519D);
Color get unfocused => const Color(0xff63666E);
Color get focusStart => const Color(0xffED8770);

Color get secondaryStart => primary;
Color get secondaryEnd => const Color(0xff657DDF);

Color get org => const Color(0xffE1914B);

Color get primaryText => const Color(0xffFFFFFF);
Color get primaryText80 => const Color(0xffFFFFFF).withOpacity(0.8);
Color get primaryText60 => const Color(0xffFFFFFF).withOpacity(0.6);
Color get primaryText35 => const Color(0xffFFFFFF).withOpacity(0.35);
Color get primaryText28 => const Color(0xffFFFFFF).withOpacity(0.28);
Color get secondaryText => const Color(0xff585A66);

List<Color> get primaryG => [focusStart, focus];
List<Color> get secondaryG => [secondaryStart, secondaryEnd];

Color get bg => const Color(0xff181B2C);
Color get darkGray => const Color(0xff383B49);
Color get lightGray => const Color(0xffD0D1D4);
