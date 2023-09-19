import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Function with Python Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firebase Function with Python Example'),
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
  void onCallByHttps() async {
    // https://stackoverflow.com/a/49498463
    // https://firebase.google.com/docs/functions/callable-reference
    // on_call function by https should be ...
    // 1. called only by post type
    // 2. headers has 'Content-Type' key and 'application/json' value
    // 3. body is json encoded string
    // 4. body has 'data' key
    // 5. response is json encodable (server side problem - functions/main.py)

    final body = jsonEncode({
      'data': {'text': 'banana'}
    });
    final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:5001/ngaeiwognaweiog/us-central1/on_call_function'),
        headers: {'Content-Type': 'application/json'},
        body: body);
    debugPrint(response.body);
  }

  void onCallByFirebase() async {
    // https://firebase.flutter.dev/docs/functions/usage#emulator-usage
    // on_call function by firebase should be ...
    // 1. flutter main function is added: FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);

    final body = {'text': 'banana'};
    final response = await FirebaseFunctions.instance
        .httpsCallable('on_call_function')
        .call(body);
    debugPrint(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: onCallByHttps,
              child: const Text('on call function by https'),
            ),
            Container(height: 10),
            ElevatedButton(
              onPressed: onCallByFirebase,
              child: const Text('on call function by firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
