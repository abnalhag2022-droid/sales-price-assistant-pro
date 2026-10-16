import 'package:flutter_test/flutter_test.dart';
import 'package:sales_price_assistant_pro/services/offline_storage_service.dart';

void main() {
  group('Sync Queue Service Tests', () {
    late OfflineStorageService offlineStorage;

    setUp(() {
      offlineStorage = OfflineStorageService();
    });

    tearDown(() async {
      await offlineStorage.clearAll();
    });

    test('Add single item to sync queue', () async {
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100, 'customer_id': 'CUST001'},
        idempotencyKey: 'test-key-1',
      );

      expect(offlineStorage.syncQueue.length, 1);
      expect(offlineStorage.syncQueue[0].endpoint, '/api/v1/sales');
      expect(offlineStorage.syncQueue[0].method, 'POST');
    });

    test('Add multiple items to sync queue', () async {
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

      expect(offlineStorage.syncQueue.length, 2);
      expect(offlineStorage.pendingSyncCount, 2);
    });

    test('Get retry queue returns pending items only', () async {
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

    test('Mark item as synced changes status', () async {
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

    test('Clear completed removes synced items', () async {
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

    test('Idempotency key is stored correctly', () async {
      const key = 'unique-key-12345';
      
      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: {'amount': 100},
        idempotencyKey: key,
      );

      expect(offlineStorage.syncQueue[0].idempotencyKey, key);
    });

    test('Payload is preserved in sync queue', () async {
      final payload = {
        'customer_id': 'CUST001',
        'amount': 500.50,
        'items': ['ITEM001', 'ITEM002'],
      };

      await offlineStorage.addToSyncQueue(
        endpoint: '/api/v1/sales',
        method: 'POST',
        payload: payload,
        idempotencyKey: 'test-key-1',
      );

      expect(offlineStorage.syncQueue[0].payload, payload);
    });
  });
}
