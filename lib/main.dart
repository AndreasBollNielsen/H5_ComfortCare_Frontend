import 'package:flutter/material.dart';
import 'pages/LoginPage.dart'; // Import your LoginPage or use the appropriate path
import 'Widgets/MainPageContent.dart'; // Import your CommonLayout or use the appropriate path
import 'pages/WorkSchedulePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn =
      true; // Set this value based on user authentication status

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF8FD19E), // Set primary color to #8FD19E
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green, // Use green swatch for primary color
        ),
        appBarTheme: AppBarTheme(),
      ),
      initialRoute: isUserLoggedIn ? '/mainPage' : '/login', // Set initial route based on user authentication
      routes: {
        '/login': (context) => LoginPage(),
        '/mainPage': (context) => CommonLayout(content: WorkSchedulePage()),
        // Add more routes for other subpages
      },
    );
  }
}

class MainPage extends StatelessWidget {
  final bool isLoggedIn;

  MainPage({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      content: Container(
          // Add your changing content here
          ),
      showBackButton: false,
      isLoggedIn: isLoggedIn,
    );
  }
}
