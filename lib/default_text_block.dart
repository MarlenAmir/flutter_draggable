// text_block_data.dart

import 'package:flutter/material.dart';
import 'package:payment_receipt_paloma365/textbloc_model.dart';



class DefaultTextBlocks {
  static List<TextBlock> getTextBlocks() {
    List<TextBlock> textBlocks = [
      TextBlock(
        fontSize: 12.0,
        text: "Добро пожаловать!",
        x: 1100.0,
        y: 50.0,
        color: Colors.black,
      ),
      TextBlock(
        fontSize: 12.0,
        text: "До свидания!",
        x: 1240.0,
        y: 50.0,
        color: Colors.black,
      ),
      // Add more default text blocks here
    ];

    return textBlocks;
  }
}
