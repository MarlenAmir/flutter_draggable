import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:payment_receipt_paloma365/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontColorDialog extends StatefulWidget {
  final ValueChanged<double> onFontSizeChanged;
  final ValueChanged<Color> onFontColorChanged;
  final ValueChanged<bool> onFontBoldChanged;
  final ValueChanged<Alignment> onTextAlignmentChanged;

  FontColorDialog({
    required this.onFontSizeChanged,
    required this.onFontColorChanged,
    required this.onFontBoldChanged,
    required this.onTextAlignmentChanged,
  });

  @override
  _FontColorDialogState createState() => _FontColorDialogState();
}

class _FontColorDialogState extends State<FontColorDialog> {
  double fontSize = 16.0;
  Color fontColor = Colors.black;
  bool isBold = false;
  Alignment? textAlignment; // Set an initial value for textAlignment


  @override
  void initState() {
    _loadSavedValues();
    super.initState();
  }

  void _saveFontSize(double fontSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
  }

  void _saveFontColor(Color fontColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String colorString = fontColor.value.toRadixString(16);
    await prefs.setString('fontColor', colorString);
  }

  void _saveFontBold(bool isBold) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isBold', isBold);
  }

  String _alignmentToString(Alignment alignment) {
    return '${alignment.x},${alignment.y}';
  }

  Alignment _stringToAlignment(String alignmentString) {
    List<String> values = alignmentString.split(',');
    double x = double.parse(values[0]);
    double y = double.parse(values[1]);
    return Alignment(x, y);
  }

  void _saveTextAlignment(Alignment alignment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String alignmentString = _alignmentToString(alignment);
    await prefs.setString('alignment', alignmentString);
  }

  void _loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fontSize = prefs.getDouble('fontSize') ?? 16.0;
      String? savedColorString = prefs.getString('fontColor');
      fontColor = savedColorString != null
          ? Color(int.parse(savedColorString, radix: 16))
          : Colors.black;
      isBold = prefs.getBool('isBold') ?? false;
      String? savedAlignmentString = prefs.getString('alignment');
      textAlignment = savedAlignmentString != null
          ? _stringToAlignment(savedAlignmentString)
          : Alignment.center;
    });


  }




  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Изменить стиль шрифта'),
      content: Column(
        children: [
          Text('Размер шрифта'),
          Slider(
            value: fontSize,
            min: 8,
            max: 24,
            onChanged: (value) {
              setState(() {
                fontSize = value;
              });
              _saveFontSize(fontSize);
              widget.onFontSizeChanged(fontSize);
            },
          ),
          Text('Цвет шрифта'),
          ColorPicker(
            pickerColor: fontColor,
            onColorChanged: (color) {
              setState(() {
                fontColor = color;
              });
              _saveFontColor(fontColor);
              print(fontColor);
              widget.onFontColorChanged(fontColor);
            },
          ),
          Text('Жирность шрифта'),
          Row(
            children: [
              Text('Сделать жирным'),
              Checkbox(
                value: isBold,
                onChanged: (value) {
                  setState(() {
                    isBold = value ?? false;
                  });
                  _saveFontBold(isBold);
                  widget.onFontBoldChanged(isBold);
                },
              ),
            ],
          ),
          Text('Выравнивание текста'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Слева'),
              Radio(
                value: Alignment.centerLeft,
                groupValue: textAlignment,
                onChanged: (alignment) {
                  setState(() {
                    textAlignment = alignment ?? Alignment.centerLeft;
                  });
                  _saveTextAlignment(textAlignment!);
                  widget.onTextAlignmentChanged(textAlignment!);
                },
              ),
              const Text('По центру'),
              Radio(
                value: Alignment.center,
                groupValue: textAlignment,
                onChanged: (alignment) {
                  setState(() {
                    textAlignment = alignment ?? Alignment.center;
                  });
                  widget.onTextAlignmentChanged(textAlignment!);
                },
              ),
              Text('Справа'),
              Radio(
                value: Alignment.centerRight,
                groupValue: textAlignment,
                onChanged: (alignment) {
                  setState(() {
                    textAlignment = alignment ?? Alignment.centerRight;
                  });
                  _saveTextAlignment(textAlignment!);

                  widget.onTextAlignmentChanged(textAlignment!);
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Готово'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
