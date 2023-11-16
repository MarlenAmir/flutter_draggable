import 'package:flutter/material.dart';
import 'package:payment_receipt_paloma365/constants.dart';

class RightExpandedWidget extends StatefulWidget {
  const RightExpandedWidget({super.key});

  @override
  State<RightExpandedWidget> createState() => _RightExpandedWidgetState();
}

class _RightExpandedWidgetState extends State<RightExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: ListView.builder(
              itemCount: groupedValues.length,
              itemBuilder: (BuildContext context, int index) {
                String key = groupedValues.keys.elementAt(index);
                List<String> values = groupedValues[key]!;
                return Draggable<Map>(
                  data: {key: values},
                  feedback: Material(
                    elevation: 4.0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(key),
                          for (String value in values) Text(value),
                        ],
                      ),
                    ),
                  ),
                  child: Container(
                    width: 150,
                    margin: EdgeInsets.only(bottom: 10, top: 10, left: 2),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListTile(
                              title: Text(key),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: values.length,
                              itemBuilder:
                                  (BuildContext context, int valueIndex) {
                                return ListTile(
                                  title: Text(values[valueIndex]),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}