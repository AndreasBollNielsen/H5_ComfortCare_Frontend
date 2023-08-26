import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Services/AuthenticationService.dart';
import '../Widgets/InactivityDialog.dart';

class AutoLogoutService {
  final AuthService authorizationService;
  late BuildContext? context;
  //countdown in seconds
  static const int inactivityDuration = (1 * 20);
  late Timer _timer = Timer(Duration.zero, () {});
  AutoLogoutService({required this.authorizationService, this.context});

  //method to reset timer
  void ResetTimer() {
    //reset timer if logged ind
    if (authorizationService.CheckLoginStatus()) {
      print('timer reset');
      _timer?.cancel();
      _timer = Timer(
          Duration(seconds: inactivityDuration),
          () => {
                print('loggin out'),
                authorizationService.Logout(context!),
                showDialog(
                  context: context!,
                  builder: (BuildContext context) {
                    return InactivityDialog();
                  },
                ),
              });
    }
  }

  void StopTimer() {
    print('timer stopped');
    _timer?.cancel();
  }
}
