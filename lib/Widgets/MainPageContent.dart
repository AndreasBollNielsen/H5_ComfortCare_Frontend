import 'package:flutter/material.dart';
import '../pages/LoginPage.dart'; // Import your LoginPage or use the appropriate path

class CommonLayout extends StatelessWidget {
  final Widget content;
  final bool showBackButton;
  final bool isLoggedIn;

  CommonLayout({
    required this.content,
    this.showBackButton = true,
    this.isLoggedIn = true, // Default to true, change to false when user is not logged in
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comfort Care'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
                leading: showBackButton && content is! LoginPage // Hide back arrow on LoginPage
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
              )
            : Builder(
                builder: (BuildContext context) {
                  // Burger menu icon for login page and pages with hidden back arrow
                  return IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
        actions: [
          if (isLoggedIn) // Show the sign-out button only when logged in
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
              title: Text('WeekSchedule'),
              onTap: () {
                // Navigate to Home page
              },
            ),
            ListTile(
              title: Text('Subpage 1'),
              onTap: () {
                Navigator.pushNamed(context, '/subpage1');
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
