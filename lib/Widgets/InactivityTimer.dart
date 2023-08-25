import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class InactivityTimer with WidgetsBindingObserver {
  static const int inactivityDuration =
      10; // 5 minutter inaktivitet (i sekunder)
  late Timer _timer = Timer(Duration.zero, () {});
  final SharedPreferences _prefs;

  InactivityTimer(this._prefs) {
    WidgetsBinding.instance?.addObserver(this);
    _resetTimer();
  }

  // reset timer
  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: inactivityDuration), _showLogoutDialog);
    _prefs.setInt('lastActivity', DateTime.now().millisecondsSinceEpoch);
  }

  //may not be used
  // show log out dialog
  void _showLogoutDialog() {
    print('Brugeren er logget ud på grund af inaktivitet.');
  }

  // listening for changes in the lifecycle and resets timer if user touches the app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final lastActivity = _prefs.getInt('lastActivity') ?? 0;
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final inactiveDuration =
          (currentTime - lastActivity) ~/ 1000; // i sekunder
      if (inactiveDuration >= inactivityDuration) {
        _showLogoutDialog();
      } else {
        _resetTimer();
      }
    }
  }
}
