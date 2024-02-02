import 'package:flutter/material.dart';
import '../widgets/chart_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitGraph Insight'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChartWidget(), // Your GitHub activity chart
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
