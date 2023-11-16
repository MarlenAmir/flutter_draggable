import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:payment_receipt_paloma365/created_reports_list.dart';
import 'package:payment_receipt_paloma365/left_expanded_widget.dart';
import 'package:payment_receipt_paloma365/constants.dart';
import 'package:payment_receipt_paloma365/data.dart';
import 'package:payment_receipt_paloma365/font_color_class.dart';
import 'package:payment_receipt_paloma365/right_expanded_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceiptPaloma extends StatefulWidget {
  const ReceiptPaloma({Key? key}) : super(key: key);

  @override
  State<ReceiptPaloma> createState() => _ReceiptPalomaState();
}

class _ReceiptPalomaState extends State<ReceiptPaloma> {
  @override
  void initState() {
    restaurantOrders.first.forEach((key, value) {
      if (value is List<Map<String, String?>>) {
        ourList = value;
      }
    });

    for (Map<String, String?> item in ourList!) {
      item.forEach((key, value) {
        if (groupedValues.containsKey(key)) {
          groupedValues[key]!.add(value ?? 'null');
        } else {
          groupedValues[key] = [value ?? 'null'];
        }
      });
    }
    loadData();
    super.initState();
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<dynamic> combinedElements = [];

    for (var element in elementsArray) {
      if (element is List) {
        Map<String, dynamic> elementMap = {
          'listData': element,
        };
        combinedElements.add(elementMap);
      } else if (element is String) {
        combinedElements.add(element);
      }
    }

    prefs.setString('combinedElements', jsonEncode(combinedElements));
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? combinedElementsJson = prefs.getString('combinedElements');
    List<dynamic> loadedData = [];
    if (combinedElementsJson != null) {
      loadedData = jsonDecode(combinedElementsJson);
    }

    List<dynamic> processedData = [];
    for (var element in loadedData) {
      if (element is Map<String, dynamic> && element.containsKey('listData')) {
        processedData.add(element['listData']);
      } else if (element is String) {
        processedData.add(element);
      }
    }

    setState(() {
      elementsArray = processedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paloma Receipt"),
        actions: [
          InkWell(
            onTap: () {
              print(elementsArray);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreatedReportsList(savedReceipts: elementsArray),
                ),
              );
            },
            child: Text("Создать чек"),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Добавить текст'),
                    content: Container(
                      height: 100.0, // Set the desired height
                      child: Column(
                        children: [
                          TextFormField(
                            controller: text,
                            decoration:
                                InputDecoration(labelText: 'Введите текст'),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            elementsArray.add(text.text);
                            saveData();
                          });
                          Navigator.of(context).pop(); // Закрываем AlertDialog
                        },
                        child: Text('Добавить'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Закрываем AlertDialog
                        },
                        child: Text('Отменить'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                Text('Добавить текст'),
                Icon(
                  Icons.text_format,
                ),
              ],
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () async {
              Uint8List? fromPicker = await ImagePickerWeb.getImageAsBytes();
              if (fromPicker != null) {
                setState(() {
                  imageBytes = fromPicker;
                  elementsArray.add(imageBytes);
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Добавить фото'), Icon(Icons.photo_camera)],
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {
              setState(() {
                elementsArray.clear();
                clearData();
              });
            },
            child: Row(
              children: [
                Text('Удалить данные чека'),
                Icon(Icons.delete_rounded)
              ],
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {
              setState(() {
                showQRcode = true;
              });
            },
            child: Row(
              children: [Text('Добавить QR'), Icon(Icons.qr_code)],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          const LeftExpandedWidget(),
          Expanded(
            child: DragTarget(
              onAccept: (element) {
                if (element != null) {
                  if (element is Map) {
                    // Check if elementsArray is empty or the last element is not a List
                    if (elementsArray.isEmpty || elementsArray.last is! List) {
                      setState(() {
                        // Add a new List containing the Map to elementsArray
                        elementsArray.add([element]);
                      });
                      saveData();
                    } else {
                      setState(() {
                        // Add the Map to the last List in elementsArray
                        elementsArray.last.add(element);
                      });
                      saveData();
                    }
                  } else if (element is String) {
                    setState(() {
                      // Add the String to elementsArray
                      elementsArray.add(element);
                    });
                    saveData();
                  }
                }
              },
              builder: (context, accepted, rejected) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                  child: Column(
                    //here i added coolumn and error exists
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: elementsArray.length,
                          itemBuilder: (context, index) {
                            if (imageBytes != null) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: Image.memory(
                                  imageBytes!,
                                  width: 120,
                                  height: 120,
                                ),
                              );
                            } else if (showQRcode == true &&
                                index == elementsArray.length - 1) {
                              // Wrap the QrImageView with a SingleChildScrollView
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(20),
                                child: QrImageView(
                                  data: 'This is a simple QR code',
                                  version: QrVersions.auto,
                                  size: 100,
                                  gapless: false,
                                ),
                              );
                            } else if (elementsArray[index] is List) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                    elementsArray[index].length, (horizIndex) {
                                  final orderData =
                                      elementsArray[index][horizIndex];
                                  final keyValueList =
                                      orderData.entries.toList();

                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return FontColorDialog(
                                              onFontSizeChanged: (fontsize) {
                                                setState(() {
                                                  listFontSize = fontsize;
                                                  print(listFontSize);
                                                });
                                              },
                                              onFontColorChanged: (fontColor) {
                                                setState(() {
                                                  listColor = fontColor;
                                                  print(listColor);
                                                });
                                              },
                                              onFontBoldChanged: (isBold) {
                                                setState(() {
                                                  isBold = listBold;
                                                  print(isBold);
                                                });
                                              },
                                              onTextAlignmentChanged:
                                                  (alignment) {});
                                        }),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${keyValueList[0].key}',
                                            style: TextStyle(
                                              color: listColor,
                                              fontWeight: listBold
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              fontSize: listFontSize,
                                            ),
                                          ),
                                          for (String value
                                              in keyValueList[0].value)
                                            Text(
                                              value,
                                              style: TextStyle(
                                                color: listColor,
                                                fontSize: listFontSize,
                                                fontWeight: listBold
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FontColorDialog(
                                        onFontSizeChanged: (newSize) {
                                          setState(() {
                                            textStyles[index] =
                                                textStyles[index].copyWith(
                                                    fontSize: newSize);
                                          });
                                        },
                                        onFontColorChanged: (newColor) {
                                          setState(() {
                                            textStyles[index] =
                                                textStyles[index]
                                                    .copyWith(color: newColor);
                                          });
                                        },
                                        onFontBoldChanged: (newBold) {
                                          setState(() {
                                            textStyles[index] =
                                                textStyles[index].copyWith(
                                                    fontWeight: newBold
                                                        ? FontWeight.bold
                                                        : FontWeight.normal);
                                          });
                                        },
                                        onTextAlignmentChanged: (alignment) {
                                          setState(() {
                                            containerAlignments[index] =
                                                alignment;
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  alignment: containerAlignments[index],
                                  child: Text(
                                    elementsArray[index],
                                    style: textStyles[index],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const RightExpandedWidget(),
        ],
      ),
    );
  }
}
