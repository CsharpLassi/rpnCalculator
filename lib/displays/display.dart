import 'package:flutter/material.dart';
import 'package:rpncalculator/data_classes/data_item.dart';
import 'package:rpncalculator/processor.dart';

class Display extends StatelessWidget {
  Display({Key key, this.state, this.height}) : super(key: key);

  final ProcessorState state;
  final double height;

  static double _fontSize = 16;

  String get _output =>
      (state != null && state.output != null) ? state.output.toString() : "";

  List<DataItem> get _stack =>
      (state != null && state.stack != null) ? state.stack : new List();

  double get _margin => 10;

  final LinearGradient _gradient =
  const LinearGradient(colors: [Colors.black26, Colors.black45]);

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.display2.copyWith(
        color: Colors.white, fontWeight: FontWeight.w200, fontSize: _fontSize);

    double stackHeight = height - 2 * _margin - 3 * _margin - _fontSize;
    double inputHeight = _fontSize + 2 * _margin;
    return Container(
        padding: EdgeInsets.only(top: _margin, bottom: _margin),
        constraints: BoxConstraints.expand(height: height),
        child: Column(
          children: [
            SizedBox(
                height: stackHeight,
                child: ListView.builder(
                  reverse: true,
                  itemCount: _stack.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    String indexString = index.toString();

                    indexString += ":";

                    DataItem item = _stack[index];

                    return Container(
                      padding: EdgeInsets.fromLTRB(_margin, 0, _margin, 0),
                      constraints:
                      BoxConstraints.expand(height: 2.5 * _fontSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(indexString,
                              style: style, textAlign: TextAlign.left),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.typeString,
                                    style: style, textAlign: TextAlign.left),
                                Text(item.toString(),
                                    style: style, textAlign: TextAlign.right)
                              ])
                        ],
                      ),
                    );
                  },
                )),
            Container(
                margin: EdgeInsets.only(top: _margin),
                padding: EdgeInsets.fromLTRB(0, _margin, _margin, _margin / 2),
                constraints: BoxConstraints.expand(height: inputHeight),
                decoration: BoxDecoration(gradient: _gradient),
                child: Text(_output, style: style, textAlign: TextAlign.right)),
          ],
        ));
  }
}
