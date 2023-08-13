import 'package:flutter/material.dart';
import 'pages/LoginPage.dart';
import 'Widgets/MainPageContent.dart';
import 'pages/WorkSchedulePage.dart';
import 'pages/DaySchedulePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false; // Set this value based on user authentication status

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Theme data settings...
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/mainPage': (context) => MainPageContent(content: WorkSchedulePage()),
        '/daySchedule': (context) => MainPageContent(content: DaySchedulePage(dayIndex: 0)),
        // Add more routes for other subpages
      },
     onGenerateRoute: (settings) {
        // Handle dynamic route generation if needed
      },
    );
  }
}
