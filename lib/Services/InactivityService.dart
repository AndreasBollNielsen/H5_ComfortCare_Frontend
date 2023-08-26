import 'dart:async';
import 'package:flutter_comfortcare/Services/AuthenticationService.dart';

class AutoLogoutService {
  final AuthService authorizationService;
  //countdown in seconds
  static const int inactivityDuration = 10;
  late Timer _timer = Timer(Duration.zero, () {});
  AutoLogoutService({required this.authorizationService});

  //method to reset timer
  void ResetTimer() {
    _timer?.cancel();
    _timer = Timer(
        Duration(seconds: inactivityDuration), () => {print('loggin out')});
  }
}
