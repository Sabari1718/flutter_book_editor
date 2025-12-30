import 'package:flutter/material.dart';
import 'editor_page.dart';
import 'reader_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Book Editor',
      theme: ThemeData(useMaterial3: true),
      home:  EditorPage(),
      routes: {
        '/reader': (_) =>  ReaderPage(),
      },
    );
  }
}
