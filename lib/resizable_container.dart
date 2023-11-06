import 'package:flutter/material.dart';

class ResizableContainer extends StatefulWidget {
  @override
  _ResizableContainerState createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double containerWidth = 400.0;
  double containerHeight = 800.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            containerWidth += details.delta.dx;
          });
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            containerHeight += details.delta.dy;
          });
        },
        child: Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ),
      ),
    );
  }
}
