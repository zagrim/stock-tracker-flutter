import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Price extends StatelessWidget {
  final double value;
  final String currency;
  final TextStyle? textStyle;

  const Price(this.value, this.currency, {this.textStyle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.currency(
        name: currency,
        decimalDigits: 2,
        customPattern: '¤ #0.00',
      ).format(value),
      style: textStyle,
    );
  }
}
