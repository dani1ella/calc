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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  List<dynamic> inputList = [0];
  String output = '0';

  void _handleClear() {
    setState(() {
      inputList = [0];
      output = '0';
    });
  }

  void _handlePress(String input) {
    setState(() {
      if (_isOperator(input)) {
        if (!_isOperator(output[output.length - 1])) {
          inputList.add(input);
          output += input;
        }
      } else if (input == '=') {
        while (inputList.length > 2) {
          double firstNumber = inputList.removeAt(0) as double;
          String operator = inputList.removeAt(0);
          double secondNumber = inputList.removeAt(0) as double;
          double partialResult = 0;

          switch (operator) {
            case '+':
              partialResult = firstNumber + secondNumber;
              break;
            case '-':
              partialResult = firstNumber - secondNumber;
              break;
            case '*':
              partialResult = firstNumber * secondNumber;
              break;
            case '/':
              if (secondNumber != 0) {
                partialResult = firstNumber / secondNumber;
              }
              break;
            case '^':
              partialResult = pow(firstNumber, secondNumber).toDouble();
              break;
          }

          inputList.insert(0, partialResult);
        }

        output = '${inputList[0]}';
      } else if (input == '√') {
        double number = double.parse(output);
        double result = sqrt(number);
        inputList = [result];
        output = result.toString();
      } else {
        double? inputNumber = double.tryParse(input);
        if (inputNumber != null) {
          if (!_isOperator(output[output.length - 1])) {
            double lastNumber = (inputList.last as double);
            lastNumber = lastNumber * 10 + inputNumber;
            inputList.last = lastNumber;

            output = output.substring(0, output.length - 1) + lastNumber.toString();
          } else {
            inputList.add(inputNumber);
            output += input;
          }
        }
      }
    });
  }

  bool _isOperator(String input) {
    return ['+', '-', '*', '/', '^'].contains(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
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
                children: <Widget>[
                  for (var i = 1; i <= 9; i++)
                    TextButton(
                      child: Text("$i", style: TextStyle(fontSize: 25)),
                      onPressed: () => _handlePress("$i"),
                    ),
                  TextButton(
                    child: Text("0", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("0"),
                  ),
                  TextButton(
                    child: Text(".", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("."),
                  ),
                  TextButton(
                    child: Text("C", style: TextStyle(fontSize: 25)),
                    onPressed: _handleClear,
                  ),
                  TextButton(
                    child: Text("+", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("+"),
                  ),
                  TextButton(
                    child: Text("-", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("-"),
                  ),
                  TextButton(
                    child: Text("*", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("*"),
                  ),
                  TextButton(
                    child: Text("/", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("/"),
                  ),
                  TextButton(
                    child: Text("^", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("^"),
                  ),
                  TextButton(
                    child: Text("√", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("√"),
                  ),
                  TextButton(
                    child: Text("=", style: TextStyle(fontSize: 25)),
                    onPressed: () => _handlePress("="),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
