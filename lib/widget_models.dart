
class PageWidget {
  final String type;
  final Map<String, dynamic> props;

  const PageWidget({
    required this.type,
    required this.props,
  });


  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "props": props,
    };
  }


  factory PageWidget.fromJson(Map<String, dynamic> json) {
    return PageWidget(
      type: json["type"] as String,
      props: Map<String, dynamic>.from(json["props"] ?? {}),
    );
  }


  bool get isText => type == "Text";
  bool get isImage => type == "Image";


  String get text => props["text"] ?? "";
  double get fontSize => (props["fontSize"] ?? 16).toDouble();
  String get imageUrl => props["url"] ?? "";
}
