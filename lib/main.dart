import 'package:flutter/material.dart';
import 'editor_page.dart';
import 'reader_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Book Editor',
      theme: ThemeData(useMaterial3: true),
      home: const EditorPage(),
      routes: {
        '/reader': (_) =>  ReaderPage(),
      },
    );
  }
}
