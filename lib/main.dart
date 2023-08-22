import 'package:flutter/material.dart';
import 'Services/AuthenticationService.dart';
import 'Widgets/InactivityTimer.dart';
import 'pages/LoginPage.dart';
import 'Widgets/MainPageContent.dart';
import 'pages/WorkSchedulePage.dart';
import 'pages/DaySchedulePage.dart';
import 'Services/RepositoryService.dart';
import 'Services/APIService.dart';
import 'Pages/DayTaskspage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initializeDateFormatting('da', null);
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final inactivityTimer = InactivityTimer(prefs);

  final apiService = ApiClient();
  final repoService = ReposService();
  final authService =
      AuthService(apiService: apiService, repoService: repoService);
  runApp(MyApp(
    authService: authService,
    reposService: repoService,
    prefs: prefs,
  ));
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
  final AuthService authService;
  final ReposService reposService;
  final SharedPreferences prefs;
  MyApp(
      {required this.authService,
      required this.reposService,
      required this.prefs});

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
              body: LoginPage(
                  authService:
                      authService), // Opret en instans af AuthService og send den som parameter
            ),

        '/mainPage': (context) {
          // Opret en ny instans af InactivityTimer og send den som parameter
          // final inactivityTimer = InactivityTimer(prefs);

          return Scaffold(
            body: MainPageContent(
              authorizationService: authService,
              content: WorkSchedulePage(
                reposService: reposService,
              ),
              title: 'Uge Visning',
              showBackButton: true,
            ),
          );
        },

        '/daySchedule': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;
          final dayIndex = arguments['dayIndex'];
          final day = arguments['day'];
          final tasks = arguments['tasks'];
          final repoService = ReposService();
          return Scaffold(
            body: MainPageContent(
              authorizationService: authService,
              content: DaySchedulePage(
                dayIndex: dayIndex,
                tasks: tasks,
                reposService: repoService,
              ),
              title: day,
              showBackButton: true,
            ),
          );
        },
        '/dayTask': (context) {
          final arg = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>;
          final currentTask = arg['task'];
          return Scaffold(
            // appBar: CustomAppBar(title: 'Main Page'),
            body: MainPageContent(
              authorizationService: authService,
              content: DayTaskPage(task: currentTask),
              title: 'opgave Visning',
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
