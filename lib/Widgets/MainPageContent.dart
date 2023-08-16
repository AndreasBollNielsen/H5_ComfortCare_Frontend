import 'package:flutter/material.dart';
import '../pages/LoginPage.dart'; // Import your LoginPage or use the appropriate path

class MainPageContent extends StatelessWidget {
  final Widget content;
  final bool showBackButton;
  final bool isLoggedIn;
  final String title;

  MainPageContent(
      {required this.content,
      this.showBackButton = false,
      this.isLoggedIn = true,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
              alignment: Alignment.centerLeft,
              child: showBackButton
                  ? IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                    )
                  : null)
        ],
        title: Text(title),
        centerTitle: true,

        leading: showBackButton
            ? BackButton(
                onPressed: () {
                  final currentRouteName =
                      ModalRoute.of(context)?.settings.name;

                  if (currentRouteName == '/daySchedule') {
                    Navigator.pop(context);
                  } else if (currentRouteName == '/dayTask') {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              )
            : null,
        // Other app bar settings...
      ),
      // drawer: showBurgerMenuButton
      //     ? Drawer(
      //         width: 180,
      //         child: Container(
      //           child: Padding(
      //             padding: const EdgeInsets.only(),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Align(
      //                   alignment: Alignment.topCenter,
      //                   child: Container(
      //                     width: 160,
      //                     height: 50,
      //                     alignment: Alignment.topCenter,
      //                     decoration: BoxDecoration(
      //                       border: Border.all(color: Colors.black),
      //                     ),
      //                     child: Text(
      //                       'Comfort Care',
      //                       style: TextStyle(fontSize: 20),
      //                     ),
      //                   ),
      //                 ),
      //                 Row(
      //                   children: [
      //                     IconButton(
      //                       icon: Icon(Icons.remove_red_eye),
      //                       onPressed: () {
      //                         Navigator.pushReplacementNamed(
      //                             context, '/mainPage');
      //                       },
      //                     ),
      //                     Text(
      //                       'Ugevisning',
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                     IconButton(
      //                       icon: Icon(Icons.person_add),
      //                       onPressed: () {
      //                         Navigator.pushReplacementNamed(context, '/login');
      //                       },
      //                     ),
      //                     Text(
      //                       'Log Ud',
      //                       style: TextStyle(fontSize: 16),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
      body: content,
    );
  }
}
