import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/services/network_status_service.dart';

void main() {
  group('Network Status Service Tests', () {
    late NetworkStatusService networkStatus;

    setUp(() {
      networkStatus = NetworkStatusService();
    });

    test('Initialize as online by default', () {
      expect(networkStatus.isOnline, true);
      expect(networkStatus.isOffline, false);
    });

    test('Simulate going offline changes status', () {
      networkStatus.simulateOffline();
      
      expect(networkStatus.isOnline, false);
      expect(networkStatus.isOffline, true);
    });

    test('Simulate coming online changes status', () {
      networkStatus.simulateOffline();
      expect(networkStatus.isOffline, true);

      networkStatus.simulateOnline();
      expect(networkStatus.isOnline, true);
      expect(networkStatus.isOffline, false);
    });

    test('Toggle between online and offline multiple times', () {
      expect(networkStatus.isOnline, true);

      networkStatus.simulateOffline();
      expect(networkStatus.isOffline, true);

      networkStatus.simulateOnline();
      expect(networkStatus.isOnline, true);

      networkStatus.simulateOffline();
      expect(networkStatus.isOffline, true);

      networkStatus.simulateOnline();
      expect(networkStatus.isOnline, true);
    });

    test('isOffline is opposite of isOnline', () {
      expect(networkStatus.isOffline, !networkStatus.isOnline);

      networkStatus.simulateOffline();
      expect(networkStatus.isOffline, !networkStatus.isOnline);
    });
  });
}
