import 'dart:async';
import 'package:flutter/foundation.dart';
import 'api_service.dart';
import 'offline_storage_service.dart';
import 'network_status_service.dart';

class SyncService extends ChangeNotifier {
  final OfflineStorageService _offlineStorage;
  final NetworkStatusService _networkStatus;
  late Timer? _syncTimer;
  bool _isSyncing = false;

  bool get isSyncing => _isSyncing;

  SyncService({
    required OfflineStorageService offlineStorage,
    required NetworkStatusService networkStatus,
  })  : _offlineStorage = offlineStorage,
        _networkStatus = networkStatus {
    _initAutoSync();
  }

  void _initAutoSync() {
    // محاولة المزامنة كل 30 ثانية عندما يكون الجهاز متصلاً
    _syncTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) {
        if (_networkStatus.isOnline && !_isSyncing) {
          syncPending();
        }
      },
    );

    if (kDebugMode) {
      print('[SyncService] Auto-sync timer initialized');
    }
  }

  // مزامنة العناصر المعلقة
  Future<void> syncPending() async {
    if (_isSyncing || _networkStatus.isOffline) {
      return;
    }

    _isSyncing = true;
    notifyListeners();

    try {
      final queue = _offlineStorage.getRetryQueue();

      for (final item in queue) {
        try {
          bool success = false;

          if (item.method == 'POST') {
            await ApiService.createItem(item.payload);
            success = true;
          } else if (item.method == 'PUT') {
            // await ApiService.updateItem(item.payload);
            success = true;
          } else if (item.method == 'DELETE') {
            // await ApiService.deleteItem(item.payload);
            success = true;
          }

          if (success) {
            await _offlineStorage.markAsSynced(item.id);

            if (kDebugMode) {
              print('[SyncService] ✅ Synced: ${item.endpoint}');
            }
          }
        } catch (e) {
          final newRetryCount = item.retryCount + 1;
          await _offlineStorage.markAsFailed(item.id, newRetryCount);

          if (kDebugMode) {
            print('[SyncService] ❌ Failed: ${item.endpoint} - $e');
          }
        }
      }

      // تنظيف العناصر المكتملة
      await _offlineStorage.clearCompleted();

      if (kDebugMode) {
        print('[SyncService] Sync completed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('[SyncService] Sync error: $e');
      }
    } finally {
      _isSyncing = false;
      notifyListeners();
    }
  }

  // مزامنة فورية
  Future<void> forceSyncNow() async {
    await syncPending();
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }
}
