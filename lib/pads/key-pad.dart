import 'package:flutter/widgets.dart';
import 'package:rpncalculator/calculator_key.dart';

class KeyPad extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CalculatorKey(symbol: Keys.clear),
            CalculatorKey(symbol: Keys.sign),
            CalculatorKey(symbol: Keys.varX),
            CalculatorKey(symbol: Keys.divide),
            CalculatorKey(symbol: Keys.swap),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorKey(symbol: Keys.seven),
            CalculatorKey(symbol: Keys.eight),
            CalculatorKey(symbol: Keys.nine),
            CalculatorKey(symbol: Keys.multiply),
            CalculatorKey(symbol: Keys.str),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorKey(symbol: Keys.four),
            CalculatorKey(symbol: Keys.five),
            CalculatorKey(symbol: Keys.six),
            CalculatorKey(symbol: Keys.subtract),
            CalculatorKey(symbol: Keys.num),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorKey(symbol: Keys.one),
            CalculatorKey(symbol: Keys.two),
            CalculatorKey(symbol: Keys.three),
            CalculatorKey(symbol: Keys.add),
          ],
        ),
        Row(
          children: <Widget>[
            CalculatorKey(symbol: Keys.zero),
            CalculatorKey(symbol: Keys.decimal),
            CalculatorKey(symbol: Keys.enter),
          ],
        ),
      ],
    );
  }
}