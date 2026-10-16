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
      expect(offlineStorage.syncQueue[0].endpoint, '/api/v1/sales');
    });

    test('Mark item as synced', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      final itemId = offlineStorage.syncQueue[0].id;
      await offlineStorage.markAsSynced(itemId);

      expect(offlineStorage.syncQueue[0].status, 'completed');
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
      expect(retryQueue[0].status, 'pending');
    });

    test('Track pending sync count', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 200},
        idempotencyKey: 'test-key-2',
      );

      expect(offlineStorage.pendingSyncCount, 2);
    });

    test('Clear completed items', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: 'test-key-1',
      );

      final itemId = offlineStorage.syncQueue[0].id;
      await offlineStorage.markAsSynced(itemId);
      await offlineStorage.clearCompleted();

      expect(offlineStorage.syncQueue.isEmpty, true);
    });
  });
}
