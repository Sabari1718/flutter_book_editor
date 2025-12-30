/// Model representing a single widget on a book page
class PageWidget {
  final String type;
  final Map<String, dynamic> props;

  const PageWidget({
    required this.type,
    required this.props,
  });

  /// Convert model to JSON (Editor → Export)
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "props": props,
    };
  }

  /// Create model from JSON (Reader → Render)
  factory PageWidget.fromJson(Map<String, dynamic> json) {
    return PageWidget(
      type: json["type"] as String,
      props: Map<String, dynamic>.from(json["props"] ?? {}),
    );
  }

  /// Helpers (optional, but nice for clean code)
  bool get isText => type == "Text";
  bool get isImage => type == "Image";

  /// Safe getters (avoid crashes)
  String get text => props["text"] ?? "";
  double get fontSize => (props["fontSize"] ?? 16).toDouble();
  String get imageUrl => props["url"] ?? "";
}
