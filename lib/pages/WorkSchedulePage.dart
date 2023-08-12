import 'package:flutter/material.dart';

class WorkSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Schedule Page'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 1; i <= 7; i++)
              Padding(
                padding: EdgeInsets.all(8.0), // Add padding between swimlanes
                child: _buildSwimlaneCard(context, 'Swimlane $i'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwimlaneCard(BuildContext context, String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6, // Adjust the width as needed
      constraints: BoxConstraints(maxHeight: 200.0), // Limit vertical height
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow offset
          ),
        ],
        border: Border.all(
          color: Colors.black.withOpacity(0.1),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text('Column 1'),
          Text('Column 2'),
          Text('Column 3'),
          // Add more columns as needed
        ],
      ),
    );
  }
}
