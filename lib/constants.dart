import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, String?>>? ourList;

  Map<String, List<String>> groupedValues = {};

  List<Widget> draggedItems = [];

  List<dynamic> elementsArray = [];

  double fontSize = 16.0; // Initial font size
  Color fontColor = Colors.black; // Initial font color
  bool isBold = false;
  Alignment? containerAlignment;

  double listFontSize = 16.0;
  Color listColor = Colors.black;
  bool listBold = false;

  TextEditingController text = TextEditingController();

  List<Alignment?> containerAlignments = List.generate(1000, (index) {
    return null; // Initial alignment for each container
  });

    Uint8List? imageBytes;

  bool showQRcode = false;


    List<TextStyle> textStyles = List.generate(1000, (index) {
    return const TextStyle(
      fontSize: 16.0, // Initial font size
      color: Colors.black, // Initial font color
      fontWeight: FontWeight.normal,
    );
  });


    void clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('combinedElements');
  }