import 'package:flutter/material.dart';
import 'package:rpncalculator/key_controller.dart';
import 'package:rpncalculator/key_symbol.dart';

abstract class Keys {
  static KeySymbol clear = const KeySymbol('←');
  static KeySymbol sign = const KeySymbol('±');
  static KeySymbol varX = const KeySymbol('x');
  static KeySymbol divide = const KeySymbol('÷');
  static KeySymbol multiply = const KeySymbol('✕');
  static KeySymbol subtract = const KeySymbol('-');
  static KeySymbol add = const KeySymbol('+');
  static KeySymbol enter = const KeySymbol('Enter', 2);
  static KeySymbol decimal = const KeySymbol('.');

  static KeySymbol swap = const KeySymbol("swp");
  static KeySymbol str = const KeySymbol("str");
  static KeySymbol num = const KeySymbol("num");

  static KeySymbol zero = const KeySymbol('0', 2);
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
}

class CalculatorKey extends StatelessWidget {
  CalculatorKey({this.symbol});

  final KeySymbol symbol;

  Color get color {
    switch (symbol.type) {
      case KeyType.FUNCTION:
        return Color.fromARGB(255, 96, 96, 96);
      case KeyType.OPERATOR:
        return Color.fromARGB(255, 32, 96, 128);
      default:
        return Color.fromARGB(255, 128, 128, 128);
    }
  }

  static dynamic _fire(CalculatorKey key) => KeyController.fire(KeyEvent(key));

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    TextStyle style =
    Theme.of(context).textTheme.display1.copyWith(color: Colors.white);

    if (symbol.value.length > 2)
      style = style.copyWith(fontSize: style.fontSize / 2);

    return Container(
      padding: EdgeInsets.all(2),
      width: symbol.size * size,
      height: size,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: color,
        elevation: 4,
        child: Text(symbol.value, style: style),
        onPressed: () => _fire(this),
      ),
    );
  }
}
