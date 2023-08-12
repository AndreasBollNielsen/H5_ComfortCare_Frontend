import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
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
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return Builder(
              builder: (context) => Center(
                child: Form(
                  child: SizedBox(
                    child: Column(
                      children: [
                        TextFormField(),
                        TextFormField(),
                        ElevatedButton(
                          onPressed: () {},
                          child: null,
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
