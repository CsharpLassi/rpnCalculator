import 'package:flutter/material.dart';
import 'package:rpncalculator/displays/display.dart';
import 'package:rpncalculator/displays/variables-display.dart';
import 'package:rpncalculator/key_controller.dart';
import 'package:rpncalculator/pads/key-pad.dart';
import 'package:rpncalculator/processor.dart';

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<Calculator> {
  ProcessorState _processorState;

  PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  void initState() {
    KeyController.listen((event){
      _controller.jumpToPage(_controller.initialPage);
      Processor.process(event);
    }
    );
    Processor.listen((data) => setState(() {
      _processorState = data;
    }));
    Processor.refresh();

    super.initState();
  }

  @override
  void dispose() {
    KeyController.dispose();
    Processor.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double buttonSize = screen.width / 4;
    double displayHeight = screen.height - (buttonSize * 3) - (buttonSize);

    return Scaffold(
      backgroundColor: Color.fromARGB(196, 32, 64, 96),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              height: displayHeight,
              child: PageView(controller: _controller, children: [
                VariablesDisplay(state: _processorState, height: displayHeight),
                Display(state: _processorState, height: displayHeight),
              ])),
          KeyPad()
        ],
      ),
    );
  }
}
