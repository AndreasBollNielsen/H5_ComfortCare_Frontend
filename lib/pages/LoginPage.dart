import 'package:flutter/material.dart';
import '../Widgets/MainPageContent.dart';
import '../Services/AuthenticationService.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService;
  LoginPage({required this.authService});

  void handleLogin(BuildContext context) async {
    // Simulate successful login

    if (_formKey.currentState!.validate()) {
      bool isSuccess = await authService.login(
          _usernameController.text, _usernameController.text);

      if (isSuccess) {
        // Navigate to the MainPage after successful login
        Navigator.pushReplacementNamed(context, '/mainPage');
      } else {
        // Navigate to the login page if login is not successful
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }
  // return isSuccess;

  @override
  Widget build(BuildContext context) {
    return MainPageContent(
        title: 'ComfortCare',
        showBackButton: false,
        content: Scaffold(
          // appBar: AppBar(
          //   title: Text('Comfort Care'),
          //   centerTitle: true,
          //   backgroundColor: Theme.of(context).primaryColor,
          // ),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Username',
                          hintText: 'Username',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'skriv venligst dit brugernavn';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                          hintText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'skriv venligst dit password.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => handleLogin(context),
                        icon: Icon(Icons.login),
                        label: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
