import 'package:flutter/material.dart';

class SkillRateColor extends Color {
  const SkillRateColor(final int value) : super(value);

  static Color getSkillRateColor(final int rate) {
    switch (rate) {
      case 1:
        return const Color(0xffC70039);
      case 2:
        return const Color(0xffEE9B00);
      case 3:
        return const Color(0xffFFFF00);
      case 4:
        return const Color(0xff13E559);
      case 5:
        return const Color(0xff086226);
    }
    return const Color(0xffC70039);
  }
}