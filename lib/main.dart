
import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Model/Task.dart';
import 'package:flutter_comfortcare/Widgets/InactivityDialog.dart';
import 'Services/AuthenticationService.dart';
import 'pages/LoginPage.dart';
import 'Widgets/MainPageContent.dart';
import 'pages/WorkSchedulePage.dart';
import 'pages/DaySchedulePage.dart';
import 'Services/RepositoryService.dart';
import 'Services/APIService.dart';
import 'Services/InactivityService.dart';
import 'Pages/DayTaskspage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timezone/data/latest.dart' as tzdata;

void main() async {
  tzdata.initializeTimeZones();
  initializeDateFormatting('da', null);
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final apiService = ApiClient();
  final repoService = ReposService();
  final authService =
      AuthService(apiService: apiService, repoService: repoService);
  final inactivityService =
      AutoLogoutService(authorizationService: authService);

  runApp(MyApp(
    authService: authService,
    reposService: repoService,
    prefs: prefs,
    inactivityService: inactivityService,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService authService;
  final ReposService reposService;
  final SharedPreferences prefs;
  final AutoLogoutService inactivityService;
  MyApp(
      {required this.authService,
      required this.reposService,
      required this.prefs,
      required this.inactivityService});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {inactivityService.ResetTimer()},
      onVerticalDragUpdate: (details) {
        inactivityService.ResetTimer();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // Theme data settings...

            ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => Scaffold(
                // appBar: CustomAppBar(title: 'Login'),
                body: LoginPage(authService: authService),
              ),

          '/mainPage': (context) {
            return Scaffold(
              body: MainPageContent(
                authorizationService: authService,
                inactivityService: inactivityService,
                content: WorkSchedulePage(
                  reposService: reposService,
                  inactivityService: inactivityService,
                ),
                title: 'Uge Visning',
                showBackButton: false,
                isLoggedIn: authService.CheckLoginStatus(),
              ),
            );
          },

          '/daySchedule': (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>;
            final tasks = arguments['tasks'] as List<Task>;
            final dayTitle = tasks[0].ConvertToDate(tasks[0].startDate);
            final repoService = ReposService();
            return Scaffold(
              body: MainPageContent(
                authorizationService: authService,
                inactivityService: inactivityService,
                content: DaySchedulePage(
                  tasks: tasks,
                  reposService: repoService,
                  inactivityService: inactivityService,
                ),
                title: dayTitle,
                showBackButton: true,
                isLoggedIn: authService.CheckLoginStatus(),
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
                inactivityService: inactivityService,
                content: DayTaskPage(task: currentTask),
                title: 'OpgaveVisning',
                showBackButton: true,
                isLoggedIn: authService.CheckLoginStatus(),
              ),
            );
          },

          // Add more routes for other subpages
        },
        onGenerateRoute: (settings) {
          // Handle dynamic route generation if needed
        },
      ),
    );
  }
}
