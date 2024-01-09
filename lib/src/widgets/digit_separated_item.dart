import 'package:flutter/widgets.dart';
import 'package:slide_countdown/src/models/base_digit.dart';
import 'package:slide_countdown/src/utils/enum.dart';
import 'package:slide_countdown/src/utils/extensions.dart';

import 'box_separated.dart';
import 'raw_digit_item.dart';
import 'separator.dart';

class DigitSeparatedItem extends BaseDigits {
  const DigitSeparatedItem({
    super.key,
    required super.duration,
    required super.timeUnit,
    required super.padding,
    required super.decoration,
    required super.style,
    required super.separatorStyle,
    super.labelStyle,
    required super.slideDirection,
    required super.curve,
    required super.countUp,
    required super.slideAnimationDuration,
    required super.separator,
    required super.textDirection,
    required super.showSeparator,
    super.separatorPadding,
    super.digitsNumber,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> digits = [];

    if (timeUnit == TimeUnit.days && duration.inDays > 999) {
      digits.add(
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: DigitType.daysThousand,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          slideAnimationDuration: slideAnimationDuration,
          digitsNumber: digitsNumber,
          curve: curve,
        ),
      );
    }

    if (timeUnit == TimeUnit.days && duration.inDays > 99) {
      digits.add(
        RawDigitItem(
          duration: duration,
          timeUnit: timeUnit,
          digitType: DigitType.daysHundred,
          countUp: countUp,
          style: style,
          slideDirection: slideDirection,
          slideAnimationDuration: slideAnimationDuration,
          digitsNumber: digitsNumber,
          curve: curve,
        ),
      );
    }

    digits.add(
      RawDigitItem(
        duration: duration,
        timeUnit: timeUnit,
        digitType: DigitType.first,
        countUp: countUp,
        style: style,
        slideDirection: slideDirection,
        slideAnimationDuration: slideAnimationDuration,
        digitsNumber: digitsNumber,
        curve: curve,
      ),
    );

    digits.add(
      RawDigitItem(
        duration: duration,
        timeUnit: timeUnit,
        digitType: DigitType.second,
        countUp: countUp,
        style: style,
        slideDirection: slideDirection,
        slideAnimationDuration: slideAnimationDuration,
        digitsNumber: digitsNumber,
        curve: curve,
      ),
    );

    Widget separatorWidget = showSeparator
        ? Separator(
            padding: separatorPadding,
            show: true,
            separator: separator,
            style: separatorStyle,
          )
        : SizedBox(
            width: timeUnit == TimeUnit.seconds ? 0 : 10.0,
          );

    final box = BoxSeparated(
      padding: padding,
      decoration: decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: digits,
      ),
    );

    String label = "";
    switch (timeUnit) {
      case TimeUnit.days:
        label = "ngày";
      case TimeUnit.hours:
        label = "giờ";
      case TimeUnit.minutes:
        label = "phút";
      case TimeUnit.seconds:
        label = "giây";
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: textDirection.isRtl
          ? [
              separatorWidget,
              box,
            ]
          : [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  box,
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: labelStyle?? TextStyle(fontSize: 10.8),
                  )
                ],
              ),
              separatorWidget,
            ],
    );
  }
}