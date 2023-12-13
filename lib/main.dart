import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _calculate() {
    try {
      ContextModel cm = ContextModel();
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      setState(() {
        _result = exp.evaluate(EvaluationType.REAL, cm).toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  double evaluateExpression() {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    return exp.evaluate(EvaluationType.REAL, ContextModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('7'),
                      _buildButton('8'),
                      _buildButton('9'),
                      _buildButton('/'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('4'),
                      _buildButton('5'),
                      _buildButton('6'),
                      _buildButton('*'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('1'),
                      _buildButton('2'),
                      _buildButton('3'),
                      _buildButton('-'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildButton('0'),
                      _buildButton('.'),
                      _buildButton('='),
                      _buildButton('+'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () {
        if (value == '=') {
          _calculate();
        } else if (value == 'C') {
          _clear();
        } else {
          _addToExpression(value);
        }
      },
      child: value == '='
          ? Text(
              value,
              style: TextStyle(fontSize: 24.0),
            )
          : Text(value),
    );
  }
}
