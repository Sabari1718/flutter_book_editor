import 'dart:convert';
import 'package:flutter/material.dart';
import 'widget_models.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  List<PageWidget> widgets = [];
  bool loaded = false;

  final String sampleJson = '''
  {
    "pageTitle": "My Lesson",
    "page_size_X": 800,
    "page_size_Y": 1000,
    "orientation": "portrait",
    "widgets": [
      {
        "type": "Text",
        "props": {
          "text": "Welcome to Science",
          "fontSize": 22,
          "color": "#333333"
        }
      },
      {
        "type": "Image",
        "props": {
          "url": "https://picsum.photos/300"
        }
      }
    ]
  }
  ''';

  void loadJson() {
    final decoded = jsonDecode(sampleJson);
    final List list = decoded["widgets"];
    widgets = list.map((e) => PageWidget.fromJson(e)).toList();
    setState(() => loaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌸 READER BACKGROUND (soft & calm)
      backgroundColor: const Color(0xFFF7F3FF),

      // 📖 CLEAN APP BAR (read mode)
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "BookEditor – Reader",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          // 🔘 LOAD JSON BUTTON
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurple,
              elevation: 3,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: loadJson,
            child: const Text(
              "Load JSON",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 16),

          // 📄 PAGE CONTENT
          Expanded(
            child: loaded
                ? Center(
              child: Container(
                width: 800,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 14,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: widgets.map(renderWidget).toList(),
                ),
              ),
            )
                : const Expanded(
              child: Center(
                child: Text(
                  "Click 'Load JSON' to view page",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🧩 RENDER WIDGETS (READ-ONLY)
  Widget renderWidget(PageWidget widget) {
    if (widget.type == "Text") {
      return Text(
        widget.props["text"],
        style: TextStyle(
          fontSize: widget.props["fontSize"].toDouble(),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
          color: Colors.black87,
        ),
      );
    } else if (widget.type == "Image") {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          widget.props["url"],
          fit: BoxFit.cover,
        ),
      );
    }
    return const SizedBox();
  }
}
