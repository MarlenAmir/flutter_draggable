import 'package:flutter/material.dart';

class CreatedReportsList extends StatefulWidget {
  final List<dynamic> savedReceipts;

  const CreatedReportsList({Key? key, required this.savedReceipts}) : super(key: key);

  @override
  State<CreatedReportsList> createState() => _CreatedReportsListState();
}

class _CreatedReportsListState extends State<CreatedReportsList> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.savedReceipts.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Receipts'),
        bottom: TabBar(
          controller: _tabController,
          tabs: List.generate(
            widget.savedReceipts.length,
            (index) => Tab(text: 'Receipt $index'),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          widget.savedReceipts.length,
          (index) => buildTabContent(widget.savedReceipts[index]),
        ),
      ),
    );
  }

  Widget buildTabContent(dynamic receiptData) {
    // Customize this method to display the full content of each saved receipt
    return ListView.builder(
      itemCount: receiptData.length,
      itemBuilder: (context, innerIndex) {
        // Adjust the widget based on your data structure
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Item: ${receiptData[innerIndex]}'),
          ),
        );
      },
    );
  }
}
