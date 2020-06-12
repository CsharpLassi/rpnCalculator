import 'dart:async';

import 'package:rpncalculator/calculator_key.dart';
import 'package:rpncalculator/data_classes/data_item.dart';
import 'package:rpncalculator/key_controller.dart';
import 'package:rpncalculator/key_symbol.dart';

class ProcessorState {
  ProcessorState(this.output, this.stack,this.storage);

  final String output;
  final List<DataItem> stack;
  final Map<String,DataItem> storage;
}

abstract class Processor {
  static List<DataItem> _stack = new List();
  static Map<String,DataItem> _storage = new Map();
  static String _output;

  static StreamController _controller = StreamController();

  static Stream get _stream => _controller.stream;

  static StreamSubscription listen(Function handler) => _stream.listen(handler);

  static void refresh() => _fire(ProcessorState(_output, _stack, _storage));

  static void _fire(ProcessorState data) => _controller.add(data);

  static dispose() => _controller.close();

  static process(dynamic event) {
    CalculatorKey key = (event as KeyEvent).key;

    switch (key.symbol.type) {
      case KeyType.FUNCTION:
        return handleFunction(key);
      case KeyType.OPERATOR:
        return handleOperator(key);
      case KeyType.INTEGER:
        return handleInteger(key);
      case KeyType.UNKNOWN:
      default:
        return handleDefault(key);
    }
  }

  static void handleDefault(CalculatorKey key) {
    return;
  }

  static void handleFunction(CalculatorKey key) {
    Map<KeySymbol, dynamic> table = {
      Keys.enter: () => _enter(),
      Keys.clear: () => _clear(),
      Keys.decimal: () => _decimal(),
      Keys.sign: () => _sign(),
      Keys.varX: () => _varX(),
      Keys.swap: () => _swap(),
      Keys.str:  () => _store(),
      Keys.num: () =>  _num(),
    };

    if (table.containsKey(key.symbol))
      table[key.symbol]();
    refresh();
  }

  static void handleOperator(CalculatorKey key) {
    Map<KeySymbol, dynamic> table = {
      Keys.add: () => _add(),
      Keys.subtract: () => _sub(),
      Keys.multiply: () => _mul(),
      Keys.divide: () => _div(),
      Keys.swap: () => _swap(),
    };

    table[key.symbol]();
    refresh();
  }

  static void handleInteger(CalculatorKey key) {
    String val = key.symbol.value;
    if (_output == null)
      _output = val;
    else
      _output = (_output == '0') ? val : _output + val;
    refresh();
  }

  static DataItem _parse(String value) {
    if (RegExp(r'^[-]?[0-9]+$').hasMatch(value))
      return DataItem(int.parse(value));
    if (RegExp(r'^[-]?[0-9]+([.][0-9]*)?$').hasMatch(value))
      return DataItem(double.parse(value));

    return DataItem(value);
  }

  static DataItem _pop() {
    if (_stack.length > 0) {
      DataItem value = _stack[0];
      _stack.removeAt(0);
      return value;
    }
    return null;
  }

  static void _push(DataItem value) {
    _stack.insert(0, value);
  }

  static void _pushFromOutput() {
    _push(_parse(_output));
  }

  static void _enter() {
    if (_output != null) {
      _pushFromOutput();
      _output = null;
    } else if (_stack.length > 0) {
      _stack.insert(0, _stack[0]);
    }
  }

  static void _clear() {
    if (_output == null) {
      _pop();
    } else {
      _output = _output.substring(0, _output.length - 1);
      if (_output.length == 0) _output = null;
    }
  }

  static void _decimal() {
    if (_output == null)
      _output = "0.";
    else
      _output += ".";
    refresh();
  }

  static void _sign() {
    if (_output != null) {
      if (_output[0] == '-')
        _output = _output.substring(1);
      else
        _output = '-' + _output;
    }
  }

  static void _add() {
    var strOp2 = _output != null ? _parse(_output) : _pop();
    var strOp1 = _pop();

    var op1 = strOp1.value;
    var op2 = strOp2.value;

    var result = (op1 + op2);
    _push(DataItem(result));
    _output = null;
  }

  static void _sub() {
    var strOp2 = _output != null ? _parse(_output) : _pop();
    var strOp1 = _pop();

    var op1 = strOp1.value;
    var op2 = strOp2.value;

    var result = (op1 - op2);
    _push(DataItem(result));
    _output = null;
  }

  static void _mul() {
    DataItem strOp2 = _output != null ? _parse(_output) : _pop();
    DataItem strOp1 = _pop();

    var op1 = strOp1.value;
    var op2 = strOp2.value;

    var result = (op1 * op2);
    _push(DataItem(result));
    _output = null;
  }

  static void _div() {
    DataItem strOp2 = _output != null ? _parse(_output) : _pop();
    DataItem strOp1 = _pop();

    var op1 = strOp1.value;
    var op2 = strOp2.value;

    var result = (op1 / op2);
    _push(DataItem(result));
    _output = null;
  }

  static void _varX() {
    if(_output == null)
      _output = "x";
    else{
      _output += "x";
    }
  }

  static void _swap(){
    DataItem op1 = _pop();
    DataItem op2 = _pop();

    _push(op1);
    _push(op2);
  }

  static void _store() {
    DataItem varItem = _output != null ? _parse(_output) : _pop();
    DataItem item = _pop();

    String varName = varItem.toString();

    _storage[varName] = item;
  }

  static void _num(){
    DataItem varItem = _output != null ? _parse(_output) : _pop();
    String varName = varItem.toString();

    if(_storage.containsKey(varName)){
      _push(_storage[varName]);
    }
  }
}
