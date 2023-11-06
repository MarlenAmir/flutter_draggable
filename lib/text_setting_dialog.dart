import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:payment_receipt_paloma365/textbloc_model.dart';

class TextSettingsDialog extends StatefulWidget {
  final TextBlock textBlock;
  final Function(TextBlock) onChanged;

  const TextSettingsDialog({super.key, 
    required this.textBlock,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TextSettingsDialogState createState() => _TextSettingsDialogState();
}

class _TextSettingsDialogState extends State<TextSettingsDialog> {
  late TextBlock updatedTextBlock;

  @override
  void initState() {
    super.initState();
    updatedTextBlock = TextBlock(
      fontSize: widget.textBlock.fontSize,
      text: widget.textBlock.text,
      x: widget.textBlock.x,
      y: widget.textBlock.y,
      color: widget.textBlock.color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройки текста'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(labelText: 'Текст'),
            onChanged: (value) {
              updatedTextBlock.text = value;
            },
          ),
          Slider(
            value: updatedTextBlock.fontSize,
            min: 10,
            max: 40,
            onChanged: (value) {
              setState(() {
                updatedTextBlock.fontSize = value;
              });
            },
          ),
          
          ColorPicker(
            pickerColor: updatedTextBlock.color,
            onColorChanged: (color) {
              updatedTextBlock.color = color;
            },
          )
        ],
      ),
      actions: <Widget>[
        InkWell(
          child: const Text('Отмена'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        InkWell(
          child: const Text('Применить'),
          onTap: () {
            widget.onChanged(updatedTextBlock);
          },
        ),
      ],
    );
  }
}