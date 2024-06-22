import 'package:flutter/material.dart';


void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _currentNumber = "0";
  String _operand = "";
  double _result = 0.0;

  void _updateOutput(String value) {
    setState(() {
      if (_output == "0" || _output == "Error") {
        _output = value;
      } else {
        _output += value;
      }
      _currentNumber = double.parse(_output).toString();
    });
  }

  void _clear() {
    setState(() {
      _output = "0";
      _currentNumber = "0";
      _operand = "";
      _result = 0.0;
    });
  }

  void _performOperation(String operand) {
    setState(() {
      if (_operand.isNotEmpty) {
        _calculate();
        _operand = operand;
        _output = _result.toString();
      } else {
        _operand = operand;
        _result = double.parse(_currentNumber);
        _output = "0";
      }
      _currentNumber = "0";
    });
  }

  void _calculate() {
    double current = double.parse(_currentNumber);
    switch (_operand) {
      case "+":
        _result += current;
        break;
      case "-":
        _result -= current;
        break;
      case "*":
        _result *= current;
        break;
      case "/":
        if (current == 0) {
          _output = "Error";
          return;
        }
        _result /= current;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48.0),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildButton("C"),
              _buildButton("0"),
              _buildButton("="),
              _buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
        ),
        onPressed: () {
          if (text == "C") {
            _clear();
          } else if (text == "=") {
            _calculate();
            _output = _result.toString();
            _operand = "";
            _currentNumber = "0";
          } else {
            _updateOutput(text);
          }
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
