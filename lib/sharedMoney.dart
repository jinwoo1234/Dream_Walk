import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferencesApp extends StatefulWidget {
  @override
  _MySharedPreferencesAppState createState() => _MySharedPreferencesAppState();
}

class _MySharedPreferencesAppState extends State<MySharedPreferencesApp> {
  late SharedPreferences _prefs;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _prefs.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SharedPreferences 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 값: $_counter'),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('증가'),
              onPressed: () => _incrementCounter(),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MySharedPreferencesApp(),
  ));
}