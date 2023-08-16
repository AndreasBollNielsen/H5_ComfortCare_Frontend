import 'package:flutter/material.dart';
import 'pages/LoginPage.dart';
import 'Widgets/MainPageContent.dart';
import 'pages/WorkSchedulePage.dart';
import 'pages/DaySchedulePage.dart';
import 'Services/RepositoryService.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   bool isUserLoggedIn =
//       false; // Set this value based on user authentication status

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           // Theme data settings...
//           ),
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => LoginPage(),
//         '/mainPage': (context) => MainPageContent(content: WorkSchedulePage()),
//         '/daySchedule': (context) =>
//             MainPageContent(content: DaySchedulePage(dayIndex: 0)),
//         // Add more routes for other subpages
//       },
//       onGenerateRoute: (settings) {
//         // Handle dynamic route generation if needed
//       },
//       home: Scaffold(
//           appBar: AppBar(
//         title: Text('ComfortCare2'),
//       )),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Theme data settings...

          ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Scaffold(
              // appBar: CustomAppBar(title: 'Login'),
              body: LoginPage(),
            ),
        '/mainPage': (context) => Scaffold(
              // appBar: CustomAppBar(title: 'Main Page'),
              body: MainPageContent(
                content: WorkSchedulePage(),
                title: 'Uge Visning',
                showBackButton: true,
              ),
            ),
        '/daySchedule': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;
          final dayIndex = arguments['dayIndex'];
          final day = arguments['day'];
          final repoService = ReposService();
          return Scaffold(
            body: MainPageContent(
              content: DaySchedulePage(
                dayIndex: dayIndex,
                reposService: repoService,
              ),
              title: day,
              showBackButton: true,
            ),
          );
        },

        // Add more routes for other subpages
      },
      onGenerateRoute: (settings) {
        // Handle dynamic route generation if needed
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
