import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/services/index.dart';

void main() {
  group('Network Status Service Tests', () {
    late NetworkStatusService networkStatus;

    setUp(() {
      networkStatus = NetworkStatusService();
    });

    test('Initialize as online by default', () {
      expect(networkStatus.isOnline, true);
    });

    test('Simulate going offline', () {
      networkStatus.simulateOffline();
      expect(networkStatus.isOffline, true);
    });

    test('Simulate coming back online', () {
      networkStatus.simulateOffline();
      networkStatus.simulateOnline();
      expect(networkStatus.isOnline, true);
    });

    test('Toggle network status', () {
      expect(networkStatus.isOnline, true);

      networkStatus.simulateOffline();
      expect(networkStatus.isOffline, true);

      networkStatus.simulateOnline();
      expect(networkStatus.isOnline, true);
    });
  });
}
