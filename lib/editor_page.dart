import 'dart:convert';
import 'package:flutter/material.dart';
import 'widget_models.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  List<PageWidget> widgets = [];

  void addText() {
    widgets.add(PageWidget(
      type: "Text",
      props: {
        "text": "Welcome to Science",
        "fontSize": 22,
        "color": "#333333",
      },
    ));
    setState(() {});
  }

  void addImage() {
    widgets.add(PageWidget(
      type: "Image",
      props: {
        "url":
        "https://picsum.photos/300?random=${DateTime.now().millisecondsSinceEpoch}"
      },
    ));
    setState(() {});
  }

  void exportJson() {
    final jsonData = {
      "pageTitle": "My Lesson",
      "page_size_X": 800,
      "page_size_Y": 1000,
      "orientation": "portrait",
      "widgets": widgets.map((e) => e.toJson()).toList(),
    };

    debugPrint(jsonEncode(jsonData));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("JSON exported (check console)")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌸 UNIQUE BACKGROUND
      backgroundColor: const Color(0xFFF6F4FF),

      // 💪 GETHA APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Flutter Book Editor",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
            color: Colors.black87,
          ),
        ),
        actions: [
          // Save button (white card)
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.save, color: Colors.deepPurple),
              onPressed: exportJson,
            ),
          ),

          // Reader button (primary action)
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu_book, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, '/reader'),
            ),
          ),
        ],
      ),

      // 📄 PAGE CANVAS
      body: Center(
        child: Container(
          width: 800,
          height: 1000,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
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
      ),

      // ➕ FLOATING ACTION BUTTONS
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.deepPurple,
            elevation: 4,
            onPressed: addText,
            child: const Icon(Icons.text_fields),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.deepPurple,
            elevation: 4,
            onPressed: addImage,
            child: const Icon(Icons.image),
          ),
        ],
      ),
    );
  }

  // 🧩 WIDGET RENDERER
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
