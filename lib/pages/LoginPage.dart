import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool handleLogin() {
      // Simulate successful login
      bool isSuccess = true;

      if (isSuccess) {
        // Navigate to the new page after successful login
        Navigator.pushReplacementNamed(context, '/newPage');
      }

      return isSuccess;
    }

    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.25, // Set width to 25% of the device width
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Lighter shadow color
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
                color: Colors.grey.shade300, width: 1), // Lighter border color
            borderRadius:
                BorderRadius.circular(8), // Slightly smaller border radius
          ),
          child: Form(
            key: _formKey,
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
                      return 'Please write your username.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
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
                      return 'Please write your password.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: handleLogin,
                  icon: Icon(Icons.login),
                  label: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
