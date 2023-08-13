import 'package:flutter/material.dart';
import '../pages/LoginPage.dart'; // Import your LoginPage or use the appropriate path

class MainPageContent extends StatelessWidget {
  final Widget content;
  final bool showBackButton;
  final bool isLoggedIn;

  MainPageContent({
    required this.content,
    this.showBackButton = true,
    this.isLoggedIn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text('Comfort Care'),
  centerTitle: true,
  backgroundColor: Theme.of(context).primaryColor,
  leading: isLoggedIn && content is! LoginPage
      ? Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        )
      : null, // Hide the leading icon if not logged in or on LoginPage
  actions: [
    if (isLoggedIn && content is! LoginPage)
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          // Implement logout functionality here
        },
      ),
  ],
),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            ListTile(
              title: Text('WeekSchedule'),
              onTap: () {
                Navigator.pushNamed(context, '/mainPage');
                // Navigate to Home page
              },
            ),
            // Add more list tiles for other menu items
          ],
        ),
      ),
      body: content, // This will display the content of each page
    );
  }
}
