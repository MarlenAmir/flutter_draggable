import 'package:flutter/material.dart';
import 'package:payment_receipt_paloma365/data.dart';

class LeftExpandedWidget extends StatefulWidget {
  const LeftExpandedWidget({super.key});

  @override
  State<LeftExpandedWidget> createState() => _LeftExpandedWidgetState();
}

class _LeftExpandedWidgetState extends State<LeftExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                    return Draggable<String>(
                      data: '$key: $value',
                      feedback: Material(
                        elevation: 4.0,
                        child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text('$key: $value')),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                        ),
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                        child: ListTile(
                          title: Text('$key: $value'),
                        ),
                      ),
                    );
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
