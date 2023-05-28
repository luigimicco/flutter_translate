import 'package:flutter/material.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp(title: 'Flutter translate'));
}

class MyApp extends StatefulWidget {
  final String title;
  const MyApp({Key? key, required this.title}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Home(title: widget.title);
  }
}
