import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorScreenState createState() => _MyCalculatorScreenState();
}

class _MyCalculatorScreenState extends State<MyCalculator> {
  String _expression = '';
  late double _result;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clearInput();
      } else {
        _expression += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      _result = double.parse(eval(_expression).toStringAsFixed(2));
      _expression = '$_expression = $_result';
    } catch (e) {
      _expression = 'Error';
    }
  }

  void _clearInput() {
    _expression = '';
    _result = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Divider(),
          GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              final buttonText = _buttonText(index);
              return TextButton(
                onPressed: () => _onButtonPressed(buttonText),
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 20.0),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _buttonText(int index){
    if( index < 9){
      return (index + 1).toString();
    } else if (index == 9){
      return '0';
    } else if (index == 10){
      return '+';
    } else if (index == 11){
      return '-';
    } else if (index ==  12){
      return '*';
    } else if (index == 13){
      return '/';
    } else if (index == 15){
      return '.';
    } else if (index == 16){
      return 'C';
    } else if ( index == 17){
      return '=';
    }
    return '';
  }

}
