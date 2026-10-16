import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/services/index.dart';

void main() {
  group('Sync Queue Service Tests', () {
    late OfflineStorageService offlineStorage;

    setUp(() {
      offlineStorage = OfflineStorageService();
    });

    test('Add item to sync queue', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      expect(offlineStorage.syncQueue.length, 1);
    });

    test('Sync queue item has endpoint', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      expect(offlineStorage.syncQueue[0].endpoint, '/api/v1/sales');
    });

    test('Get retry queue pending items', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      final retryQueue = offlineStorage.getRetryQueue();
      expect(retryQueue.length, 1);
    });

    test('Track pending sync count', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/items',
        method: 'POST',
        payload: {'amount': 200},
        idempotencyKey: 'test-key-2',
      );

      expect(offlineStorage.pendingSyncCount, 2);
    });
  });
}
