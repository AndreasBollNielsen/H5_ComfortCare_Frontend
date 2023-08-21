import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Widgets/MainPageContent.dart';
import '../Services/AuthenticationService.dart';
import '../Widgets/InternetDialog.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final AuthService authService;

  LoginPage({required this.authService});

  void handleLogin(BuildContext context) async {
    //disable focus on input fields
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    //check if user has filled out form
    if (_formKey.currentState!.validate()) {
      var response = await authService.login(
          _usernameController.text, _usernameController.text);

      //if successful response check status codes
      if (response != null) {
        //successful login
        if (response.statusCode == 200) {
          print('navigating to next page');

          // Navigate to the MainPage after successful login
          Navigator.pushReplacementNamed(context, '/mainPage');
        } else if (response.statusCode == 504) {
          //present error message to the user
          //print('error: ${response.message}');

          //show dialog box
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return InternetDialog();
            },
          );

          // if (result != null) {
          //   // Dialogen er blevet lukket
          //   _completer.complete(result); // Fuldfør Completer med resultatet
          // }

          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return AlertDialog(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(
          //               20.0), // Juster værdien efter dit ønske.
          //         ),
          //         title: Text('Ingen internet'),
          //         content: Text(
          //             'Du bliver stadig logget ind, men\ndine visninger bliver ikke opdateret, eller rapporter uploadet,\nfør du får forbindelse igen.\nVil du fortsætte?'),
          //         actions: <Widget>[
          //           TextButton(
          //             child: Text('Nej'),
          //             onPressed: () {
          //               _formKey.currentState?.reset();
          //               Navigator.of(context).pop(); // Luk dialogen.
          //             },
          //           ),
          //           TextButton(
          //             child: Text('Ja'),
          //             onPressed: () {
          //               // Navigator.of(context).pop(); // Luk dialogen.
          //               Navigator.pushReplacementNamed(context, '/mainPage');
          //             },
          //           ),
          //         ],
          //       );
          //     });
        }
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
                        focusNode: _usernameFocusNode,
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
                        focusNode: _passwordFocusNode,
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
