import 'dart:async';
import 'package:flutter/foundation.dart';

class NetworkStatusService extends ChangeNotifier {
  bool _isOnline = true;
  late StreamSubscription<bool> _subscription;

  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  NetworkStatusService() {
    _initNetworkStatus();
  }

  void _initNetworkStatus() {
    // Simulate network status checking
    // في التطبيق الحقيقي، استخدم connectivity_plus package
    _isOnline = true;
    notifyListeners();

    if (kDebugMode) {
      print('[NetworkStatus] Service initialized');
    }
  }

  // Simulate going offline
  void simulateOffline() {
    _isOnline = false;
    notifyListeners();

    if (kDebugMode) {
      print('[NetworkStatus] App is now OFFLINE');
    }
  }

  // Simulate coming online
  void simulateOnline() {
    _isOnline = true;
    notifyListeners();

    if (kDebugMode) {
      print('[NetworkStatus] App is now ONLINE');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
