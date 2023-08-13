import 'package:flutter/material.dart';
import '/Services/AuthenticationService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthService _authenticationService;
  @override
  void initState() {
    super.initState();
    _authenticationService = AuthService();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Builder(
        builder: (context) => FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // if (!snapshot.hasData) {
            //   return const CircularProgressIndicator();
            // }
            return Builder(
              builder: (context) => Center(
                child: Form(
                  child: SizedBox(
                    child: Column(
                      children: [
                        TextFormField(),
                        TextFormField(),
                        ElevatedButton(
                          onPressed: () async {
                            final loginSuccess = await _authenticationService
                                .login('username', 'password');

                            if (loginSuccess) {
                              //proceed to login page
                              print("logged in successful");
                            } else {
                              //show login error
                            }
                          },
                          child: Text('Login'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
