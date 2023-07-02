import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Percent extends StatelessWidget {
  final double _value;
  final TextStyle _textStyle;

  const Percent(this._value, {TextStyle? textStyle, Key? key})
      : _textStyle = textStyle ?? const TextStyle(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      NumberFormat.decimalPercentPattern(decimalDigits: 2).format(_value),
      style: _textStyle.copyWith(color: _value < 0 ? Colors.red : Colors.green),
    );
  }
}
