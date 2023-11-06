import 'dart:ui';

class ItemData {
  final String itemName;
  final int itemQuantity;

  ItemData(this.itemName, this.itemQuantity);
}


class TextBlock {
  double fontSize;
  String text;
  double x;
  double y;
  Color color;
  bool isDragging = false; // Add this variable

  TextBlock({
    required this.fontSize,
    required this.text,
    required this.x,
    required this.y,
    required this.color,
  });
}
