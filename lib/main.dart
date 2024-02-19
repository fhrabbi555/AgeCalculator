import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Age Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateController = TextEditingController();
  String _ageResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Enter your birthdate (YYYY-MM-DD)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateAge,
              child: Text('Calculate Age'),
            ),
            SizedBox(height: 20),
            Text(
              _ageResult,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  void calculateAge() {
    String input = _dateController.text;
    List<String> parts = input.split('-');
    if (parts.length == 3) {
      int? year = int.tryParse(parts[0]);
      int? month = int.tryParse(parts[1]);
      int? day = int.tryParse(parts[2]);
      if (year != null && month != null && day != null) {
        DateTime birthDate = DateTime(year, month, day);
        DateTime currentDate = DateTime.now();
        Duration difference = currentDate.difference(birthDate);
        int ageInYears = (difference.inDays / 365).floor();
        setState(() {
          _ageResult = 'Your age is $ageInYears years.';
        });
        return;
      }
    }
    setState(() {
      _ageResult = 'Invalid input. Please enter a valid birthdate.';
    });
  }
}
