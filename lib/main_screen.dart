import 'package:flutter/material.dart';

class ReceiptPaloma extends StatefulWidget {
  const ReceiptPaloma({Key? key}) : super(key: key);

  @override
  State<ReceiptPaloma> createState() => _ReceiptPalomaState();
}

class _ReceiptPalomaState extends State<ReceiptPaloma> {
  List<Map<String, String?>>? ourList;
  Map<String, List<String>> groupedValues = {};
  List<Widget> draggedItems = [];

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paloma Receipt"),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.yellow,
              child: ListView.builder(
                itemCount: restaurantOrders.length,
                itemBuilder: (context, index) {
                  final order = restaurantOrders[index];
                  final keys = order.keys.toList();
                  final values = order.values.toList();

                  return Card(
                    child: Column(
                      children: List.generate(keys.length, (i) {
                        final key = keys[i];
                        final value = values[i];
                        if (value is List) {
                          return Container();
                        } else {
                          return Draggable<Widget>(
                            data: Text('$key: $value'),
                            feedback: Material(
                              elevation: 4.0,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text('$key: $value')
                              ),
                            ),
                            childWhenDragging: Container(),
                            child: ListTile(
                              title: Text('$key: $value'),
                            ),
                          );
                        }
                      }),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: DragTarget<Widget>(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: draggedItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = draggedItems[index];
                    return Material(
                      elevation: 4.0,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: item,
                      ),
                    );
                  },
                );
              },
              onAccept: (data) {
                setState(() {
                  draggedItems.add(data);
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: ListView.builder(
                itemCount: groupedValues.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = groupedValues.keys.elementAt(index);
                  List<String> values = groupedValues[key]!;

                  return Draggable<Widget>(
                    data: Column(
                      children: [
                        Text(key),
                        for (String value in values)
                          Text(value),
                      ],
                    ),
                    feedback: Material(
                      elevation: 4.0,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(key),
                            for (String value in values)
                              Text(value),
                          ],
                        ),
                      ),
                    ),
                    childWhenDragging: Container(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Text(key),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: values.length,
                          itemBuilder: (BuildContext context, int valueIndex) {
                            return ListTile(
                              title: Text(values[valueIndex]),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> restaurantOrders = [
  {
    "id": "100",
    "creationdt": "2015-08-29 16:36:01",
    "employeeid": "1",
    "my_lable_employee": "Name of client: ",
    "my_name_employee": "John",
    "clientid": "1",
    "objectid": "0",
    "my_name_table": "Table 1",
    "paymentid": "1",
    "servicepercent": "0",
    "handservicepercent": "0",
    "discountpercent": "0",
    "discountsum": "0.00000",
    "printed": "0",
    "closed": "1",
    "dtclose": "2015-08-29 16:36:01",
    "note": "",
    "guestcount": "1",
    "totalsum": "270.00000",
    "subtotal": "0.00",
    "t_order": [
      {
        "id": "244",
        "idout": "244",
        "idlink": "2442015-08-29 16:36:01",
        "parentid": "0",
        "isgroup": "0",
        "name": "Milk",
        "orderid": "100",
        "itemid": "2271",
        "price": "175.00000",
        "sum": "175.00000",
        "quantity": "1.00000",
        "iddoc": null,
        "label": null,
        "dt": "2015-08-29 16:36:01",
        "printed": "0",
        "printerid": "0",
        "complex": "0",
        "note": "",
        "servicepercent": null,
        "servicesum": "0.00000",
        "discountpercent": null,
        "discountsum": "0.00000",
        "salesum": "175.00000",
        "coocked": "0",
        "specificationid": "0",
        "measure_id": "0",
        "mark_deleted": "0"
      },
      {
        "id": "245",
        "idout": "245",
        "idlink": "2452015-08-29 16:36:01",
        "parentid": "0",
        "isgroup": "0",
        "name": "Chocolate",
        "orderid": "101",
        "itemid": "2492",
        "price": "95.00000",
        "sum": "95.00000",
        "quantity": "1.00000",
        "iddoc": null,
        "label": null,
        "dt": "2015-08-29 16:36:01",
        "printed": "0",
        "printerid": "0",
        "complex": "0",
        "note": "",
        "servicepercent": null,
        "servicesum": "0.00000",
        "discountpercent": null,
        "discountsum": "0.00000",
        "salesum": "95.00000",
        "coocked": "0",
        "specificationid": "0",
        "measure_id": "0",
        "mark_deleted": "0"
      }
    ],
  }
];

/*
ListView.builder(
                itemCount: orderData.keys.length,
                itemBuilder: (context, index) {
                  final entry = orderData.entries.elementAt(index);
                  final key = entry.key;
                  final value = entry.value;

                  // Check if the value is a map, and if so, create a sublist of Text widgets
                  final valueWidgets = (value is Map)
                      ? value.entries
                          .map(
                            (entry) => GestureDetector(
                              onTap: (){
                              },
                              child: Text(
                                "${entry.key}: ${entry.value.toString()}",
                              ),
                            ),
                          )
                          .toList()
                      : [Text(value.toString())];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$key:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: valueWidgets,
                      ),
                      SizedBox(height: 8.0),
                    ],
                  );
                },
              ),

 */

/*
GlobalKey containerKey = GlobalKey();
  Offset selectedDishPosition = Offset(1100.w, 100.h);
  Offset selectedQuantityPosition = Offset(1270.w, 100.h);
  Offset selectedTotalSumPosition = Offset(1200.w, 180.h);
  Offset selectedPricePosition = Offset(1100.w, 180.h);
  Offset openOrderTimePosition = const Offset(1100, 260);
  Offset closeOrderTimePosition = const Offset(1100, 320);

  double containerWidth = 400.w;
  double containerHeight = 50.h;
  double? containerHeightAfter;

  bool increaseFromDishNameContainerSize = false; // Добавьте флаг
  bool increaseFromOpenOrderContainterSize = false;
  bool increaseFromCloseOrderContainterSize = false;
  bool increaseFromTotalPriceContainerSize = false;

  Uint8List? selectedImage;

  
  bool isDragging = false;
  List<TextBlock> textBlocks = DefaultTextBlocks
      .getTextBlocks(); // Use the new class to get default text blocks

  void _addTextBlock(TextBlock textBlock) {
    setState(() {
      textBlocks.add(textBlock);
    });
  }

  @override
  void initState() {
    super.initState();
    //loadSelectedPosition();
    //loadContainerHeightFromPrefs();
  }

  

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      selectedImage = result.files.single.bytes;
      setState(() {
        // Trigger a rebuild to display the selected image
      });
    }
  }

  void _showTextSettingsDialog(TextBlock textBlock) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TextSettingsDialog(
          textBlock: textBlock,
          onChanged: (updatedTextBlock) {
            setState(() {
              final index = textBlocks.indexOf(textBlock);
              if (index != -1) {
                textBlocks[index] = updatedTextBlock;
              }

              Navigator.of(context).pop();
            });
          },
        );
      },
    );
  }

  void loadSelectedPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //  Offset selectedDishPosition = Offset(1100.w, 100.h);

    double selectedDishpositionDx =
        prefs.getDouble('selectedDishPosition_dx') ?? 1100;
    double selectedDishpositionDy =
        prefs.getDouble('selectedDishPosition_dy') ?? 100;


    //  Offset selectedPricePosition = Offset(1100.w, 180.h);

    double selectedPricepositionDx =
        prefs.getDouble('selectedPricePosition_dx') ?? 1100;
    double selectedPricepositionDy =
        prefs.getDouble('selectedPricePosition_dy') ?? 220;


    //  Offset selectedQuantityPosition = Offset(1270.w, 100.h);

    double selectedQuantitypositionDx =
        prefs.getDouble('selectedQuantityPosition_dx') ?? 1270;
    double selectedQuantitypositionDy =
        prefs.getDouble('selectedQuantityPosition_dy') ?? 100;


    //  Offset selectedTotalSumPosition = Offset(1200.w, 180.h);

    double selectedTotalPricepositionDx =
        prefs.getDouble('selectedTotalPricePosition_dx') ?? 1200;
    double selectedTotalPricepositionDy =
        prefs.getDouble('selectedTotalPricePosition_dy') ?? 260;

    //  Offset openOrderTimePosition = const Offset(1100, 260);


    double selectedOpenOrderpositionDx =
        prefs.getDouble('selectedOpenOrderPosition_dx') ?? 1100;

    double selectedOpenOrderpositionDy =
        prefs.getDouble('selectedOpenOrderPosition_dy') ?? 380;

    //  Offset closeOrderTimePosition = const Offset(1100, 320);

    double selectedCloseOrderpositionDx =
        prefs.getDouble('selectedCloseOrderPosition_dx') ?? 1100;

    double selectedCloseOrderpositionDy =
        prefs.getDouble('selectedCloseOrderPosition_dy') ?? 420;

    setState(() {
      selectedDishPosition =
          Offset(selectedDishpositionDx, selectedDishpositionDy);
      selectedPricePosition =
          Offset(selectedPricepositionDx, selectedPricepositionDy);

      selectedQuantityPosition =
          Offset(selectedQuantitypositionDx, selectedQuantitypositionDy);

      selectedTotalSumPosition =
          Offset(selectedTotalPricepositionDx, selectedTotalPricepositionDy);

      openOrderTimePosition =
          Offset(selectedOpenOrderpositionDx, selectedOpenOrderpositionDy);

      closeOrderTimePosition =
          Offset(selectedCloseOrderpositionDx, selectedCloseOrderpositionDy);
    });
  }

  // Method to save containerHeight to SharedPreferences
  void saveContainerHeightToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('containerHeight', containerHeight);
  }

  Future<double> loadContainerHeightFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      containerHeight = prefs.getDouble('containerHeight') ?? 0.0;
    });

    return containerHeight;
  }

  void saveSelectedPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('selectedDishPosition_dx', selectedDishPosition.dx);
    await prefs.setDouble('selectedDishPosition_dy', selectedDishPosition.dy);

    await prefs.setDouble('selectedPricePosition_dx', selectedPricePosition.dx);
    await prefs.setDouble('selectedPricePosition_dy', selectedPricePosition.dy);

    await prefs.setDouble(
        'selectedQuantityPosition_dx', selectedQuantityPosition.dx);
    await prefs.setDouble(
        'selectedQuantityPosition_dy', selectedQuantityPosition.dy);

    await prefs.setDouble(
        'selectedTotalPricePosition_dx', selectedTotalSumPosition.dx);
    await prefs.setDouble(
        'selectedTotalPricePosition_dy', selectedTotalSumPosition.dy);

    await prefs.setDouble(
        'selectedOpenOrderPosition_dx', openOrderTimePosition.dx);
    await prefs.setDouble(
        'selectedOpenOrderPosition_dy', openOrderTimePosition.dy);

    await prefs.setDouble(
        'selectedCloseOrderPosition_dx', closeOrderTimePosition.dx);
    await prefs.setDouble(
        'selectedCloseOrderPosition_dy', closeOrderTimePosition.dy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Изменение размера шрифта и перемещение'),
      ),
      body: Stack(
        children: [
          Positioned(
            right: 0.w,
            child: Container(
              width: 350.w,
              height: 815.h,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          ),
          Positioned(
            top: 630.h,
            right: 170.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  containerHeight += 40.h;
                  saveContainerHeightToPrefs();
                });
              },
              child: Text(
                'Увеличить высоту чека',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
          Positioned(
            top: 590.h,
            right: 165.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  containerHeight -= 40.h;
                  saveContainerHeightToPrefs();
                });
              },
              child: Text(
                'Уменьшить высоту чека',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
          Positioned(
            top: 670.h,
            right: 180.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                _addTextBlock(TextBlock(
                  fontSize: 12.0.sp,
                  text: "Измените текст",
                  x: 100.0.w,
                  y: 100.0.h,
                  color: Colors.black,
                ));
              },
              child: Text(
                'Добавить свой текст',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
          Positioned(
              top: 710.h,
              right: 190.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: _pickImage, // Call the image picking method
                child: Row(
                  children: [
                    Text(
                      'Добавить картинку',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              )),
          Center(
            child: Container(
              width: containerWidth.w,
              height: containerHeight.h,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
            ),
          ),
          Positioned(
            left: 680.w,
            top: 20.h,
            child: selectedImage != null
                ? Image.memory(
                    selectedImage!,
                    height: 100.h,
                  )
                : const SizedBox(),
          ),
          Positioned(
            left: selectedDishPosition.dx,
            top: selectedDishPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  selectedDishPosition += details.delta;
                  saveSelectedPosition(); // Сохраняем позицию при обновлении
                                      print('before $containerHeight');

                  if (!increaseFromDishNameContainerSize) {
                    containerHeight += 15.h * orderData["t_order"].length;

                    print('after $containerHeight');

                    containerHeightAfter = containerHeight;

                    saveContainerHeightToPrefs();

                    increaseFromDishNameContainerSize =
                        true; // Устанавливаем флаг в true только один раз
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Название блюда'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: orderData["t_order"].map<Widget>((orderItem) {
                        return Text(orderItem["name"]);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: selectedQuantityPosition.dx,
            top: selectedQuantityPosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  selectedQuantityPosition += details.delta;
                  saveSelectedPosition();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Количество'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: orderData["t_order"].map<Widget>((orderItem) {
                        return Text(orderItem["quantity"]);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: selectedTotalSumPosition.dx,
            top: selectedTotalSumPosition.dy,
            child: GestureDetector(
              onTap: () {},
              onPanUpdate: (details) {
                setState(() {
                  selectedTotalSumPosition += details.delta;
                  saveSelectedPosition();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text('Итого:'),
                    Text(orderData["d_order"]["totalsum"]),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: selectedPricePosition.dx,
            top: selectedPricePosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  selectedPricePosition += details.delta;
                  saveSelectedPosition();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Цена'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: orderData["t_order"].map<Widget>((orderItem) {
                        return Text(orderItem["price"]);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: openOrderTimePosition.dx,
            top: openOrderTimePosition.dy,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  openOrderTimePosition += details.delta;
                  saveSelectedPosition();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text('Время открытия заказа:'),
                    Text(orderData["d_order"]["creationdt"]),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: closeOrderTimePosition.dx,
            top: closeOrderTimePosition.dy,
            child: GestureDetector(
              onTap: () {},
              onPanUpdate: (details) {
                setState(() {
                  closeOrderTimePosition += details.delta;
                  saveSelectedPosition();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text('Время закрытия заказа: '),
                    Text(orderData["d_order"]["dtclose"]),
                  ],
                ),
              ),
            ),
          ),
          Stack(
            children: textBlocks.map((textBlock) {
              double maxWidth = MediaQuery.of(context).size.width - 200.w;
              double maxHeight = MediaQuery.of(context).size.height - 100.h;
              double x = textBlock.x;
              double y = textBlock.y;

              return Positioned(
                left: x,
                top: y,
                child: GestureDetector(
                  onTap: () => _showTextSettingsDialog(textBlock),
                  onPanUpdate: (details) {
                    double newX = x + details.delta.dx;
                    double newY = y + details.delta.dy;

                    if (newX < 0) {
                      newX = 0;
                    } else if (newX > maxWidth) {
                      newX = maxWidth;
                    }

                    if (newY < 0) {
                      newY = 0;
                    } else if (newY > maxHeight) {
                      newY = maxHeight;
                    }

                    setState(() {
                      textBlock.x = newX;
                      textBlock.y = newY;
                      textBlock.isDragging =
                          true; // Set the dragging flag to true for this specific text block
                    });
                  },
                  child: textBlock.isDragging
                      ? Container(
                          child: Text(
                            textBlock.text,
                            style: TextStyle(
                              fontSize: textBlock.fontSize,
                              color: textBlock.color,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textBlock.text,
                            style: TextStyle(
                              fontSize: textBlock.fontSize,
                              color: textBlock.color,
                            ),
                          ),
                        ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }


 */
