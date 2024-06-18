import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = '0';
  String _currentValue = '0';
  String _operator = '';
  bool _shouldClear = false;

  void _handlePress(String input) {
    setState(() {
      if (input == 'C') {
        output = '0';
        _currentValue = '0';
        _operator = '';
        _shouldClear = false;
      } else if (input == '+' || input == '-' || input == '*' || input == '/' || input == '^') {
        if (_operator.isEmpty) {
          _currentValue = output;
        } else {
          _calculate();
        }
        _operator = input;
        _shouldClear = true;
      } else if (input == '=') {
        _calculate();
        _operator = '';
      } else if (input == '√') {
        double number = double.parse(output);
        output = sqrt(number).toString();
        _currentValue = output;
      } else {
        if (_shouldClear) {
          output = input;
          _shouldClear = false;
        } else {
          if (output == '0' && input != '.') {
            output = input;
          } else {
            output += input;
          }
        }
      }
    });
  }

  void _calculate() {
    double firstNumber = double.parse(_currentValue);
    double secondNumber = double.parse(output);
    double result = 0;

    switch (_operator) {
      case '+':
        result = firstNumber + secondNumber;
        break;
      case '-':
        result = firstNumber - secondNumber;
        break;
      case '*':
        result = firstNumber * secondNumber;
        break;
      case '/':
        result = secondNumber != 0 ? firstNumber / secondNumber : double.infinity;
        break;
      case '^':
        result = pow(firstNumber, secondNumber).toDouble();
        break;
    }

    output = result.toString();
    _currentValue = output;
    _shouldClear = true;
  }

  Widget _buildButton(String text, {Color color = Colors.black}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 25),
      ),
      onPressed: () => _handlePress(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
                decoration: InputDecoration(border: InputBorder.none),
                controller: TextEditingController()..text = output,
                readOnly: true,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: <Widget>[
                  for (var i = 1; i <= 9; i++) _buildButton("$i"),
                  _buildButton("0"),
                  _buildButton(".", color: Colors.blue),
                  _buildButton("C", color: Colors.red),
                  _buildButton("+", color: Colors.blue),
                  _buildButton("-", color: Colors.blue),
                  _buildButton("*", color: Colors.blue),
                  _buildButton("/", color: Colors.blue),
                  _buildButton("^", color: Colors.blue),
                  _buildButton("√", color: Colors.blue),
                  _buildButton("=", color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
