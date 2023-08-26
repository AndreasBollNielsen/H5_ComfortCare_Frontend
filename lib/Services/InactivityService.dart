import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Services/AuthenticationService.dart';

class AutoLogoutService {
  final AuthService authorizationService;
  late BuildContext? context;
  //countdown in seconds
  static const int inactivityDuration = (60 * 20);
  late Timer _timer = Timer(Duration.zero, () {});
  AutoLogoutService({required this.authorizationService, this.context});

  //method to reset timer
  void ResetTimer() {
    //reset timer if logged ind
    if (authorizationService.CheckLoginStatus()) {
      _timer?.cancel();
      _timer = Timer(Duration(seconds: inactivityDuration),
          () => {print('loggin out'), authorizationService.Logout(context!)});
    }
  }
}
