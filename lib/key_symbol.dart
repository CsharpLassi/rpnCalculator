import 'package:rpncalculator/calculator_key.dart';

enum KeyType { FUNCTION, OPERATOR, INTEGER, UNKNOWN }

class KeySymbol {
  const KeySymbol(this.value, [this.size = 1]);

  final String value;
  final int size;

  static List<KeySymbol> _functions = [
    Keys.clear,
    Keys.sign,
    Keys.varX,
    Keys.decimal,
    Keys.enter,
    Keys.str,
    Keys.swap,
    Keys.num,
  ];
  static List<KeySymbol> _operators = [
    Keys.divide,
    Keys.multiply,
    Keys.subtract,
    Keys.add
  ];

  @override
  String toString() => value;

  bool get isOperator => _operators.contains(this);

  bool get isFunction => _functions.contains(this);

  bool get isInteger => !isOperator && !isFunction;

  KeyType get type {
    if (isInteger) {
      return KeyType.INTEGER;
    } else if (isFunction) {
      return KeyType.FUNCTION;
    } else if (isOperator) {
      return KeyType.OPERATOR;
    }

    return KeyType.UNKNOWN;
  }
}
