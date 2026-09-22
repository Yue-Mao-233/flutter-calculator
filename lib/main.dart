import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // External package for expression evaluation

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    if (_expression.isEmpty) {
      return;
    }

    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});

      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }
  void _square() {
  if (_expression.isEmpty) {
    return;
  }

  try {
    final expression = Expression.parse(_expression);
    final evaluator = const ExpressionEvaluator();
    final result = evaluator.eval(expression, {});

    if (result is num) {
      setState(() {
        _expression = (result * result).toString();
        _result = '';
      });
    } else {
      setState(() {
        _result = 'Error';
      });
    }
  } catch (e) {
    setState(() {
      _result = 'Error';
    });
  }
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the calculator functions above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the
        // AppBar change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Yue Mao Calculator'),
      ),

      body: Column(
        children: [
          // Calculator display
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _expression.isEmpty
                    ? _expression
                    : '$_expression = $_result',
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
          ),

          // Calculator buttons
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            padding: const EdgeInsets.all(12),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _button('7'),
              _button('8'),
              _button('9'),
              _button('/'),

              _button('4'),
              _button('5'),
              _button('6'),
              _button('*'),

              _button('1'),
              _button('2'),
              _button('3'),
              _button('-'),

              _button('0'),
              _button('C'),
              _button('='),
              _button('+'),
              _button('x^2')
            ],
          ),
        ],
      ),
    );
  }

  Widget _button(String text) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'C') {
          _clear();
        } else if (text == '=') {
          _calculate();
        } else if (text == 'x^2') {
          _square();
        } else {
          _addToExpression(text);
        }
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}