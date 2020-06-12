import 'package:flutter/material.dart';
import 'package:rpncalculator/data_classes/data_item.dart';
import 'package:rpncalculator/processor.dart';


class VariablesDisplay extends StatelessWidget {
  VariablesDisplay({Key key, this.state, this.height}) : super(key: key);

  final ProcessorState state;
  final double height;

  static double _fontSize = 16;

  double get _margin => 10;

  Map<String, DataItem> get _storage =>
      (state != null && state.storage != null) ? state.storage : new Map();

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme
        .of(context)
        .textTheme
        .display2
        .copyWith(
        color: Colors.white, fontWeight: FontWeight.w200, fontSize: _fontSize);

    double listHeight = height - 2 * _margin;
    return Container(
        padding: EdgeInsets.only(top: _margin, bottom: _margin),
        constraints: BoxConstraints.expand(height: height),
        child: Column(
          children: [
            SizedBox(
                height: listHeight,
                child: ListView.builder(
                  reverse: false,
                  itemCount: _storage.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    String key = _storage.keys.elementAt(index);
                    String indexString = key.toString();

                    indexString += ":";

                    DataItem item = _storage[key];

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
          ],
        ));
  }
}