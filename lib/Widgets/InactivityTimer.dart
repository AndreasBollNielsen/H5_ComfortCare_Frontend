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

  // Nulstil timeren og opdater sidstAktivitet tidspunkt.
  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: inactivityDuration), _showLogoutDialog);
    _prefs.setInt('lastActivity', DateTime.now().millisecondsSinceEpoch);
  }

  // Vis logout-dialogboksen.
  void _showLogoutDialog() {
    // Implementér visning af dialogboksen her.
    print('Brugeren er logget ud på grund af inaktivitet.');
  }

  // Lyt til livscyklushændelser og nulstil timeren ved aktivitet.
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
