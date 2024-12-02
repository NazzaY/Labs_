import 'package:flutter/material.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (

      title: 'Lab1',
      theme: ThemeData.dark(), 
      home: const MyHomePage(title: 'Lab1'),
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  int _counter = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() 
  {
    super.initState();
  }

  void _incrementCounter() 
  {
    setState(() 
    {
      String input = _controller.text;

      if (input == "r" || input == "R") 
        {
          _counter = 0;
        } 
      else 
        {
        int? incrementValue = int.tryParse(input);
        if (incrementValue != null) {
          _counter += incrementValue;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text(widget.title),
      ),
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            Text
            (
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding
            (
              padding: const EdgeInsets.all(16.0),
              child: TextField
              (
                controller: _controller,
                decoration: const InputDecoration
                (
                  border: OutlineInputBorder(),
                  labelText: 'Num to add',
                ),
              ),
            ),
            const Text
            (
              '[R]eset counter',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton
            (
              onPressed: _incrementCounter,
              child: const Text('Add'),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}
