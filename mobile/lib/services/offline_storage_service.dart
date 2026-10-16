import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/index.dart';

class OfflineStorageService extends ChangeNotifier {
  // In-memory storage for offline data
  final Map<String, dynamic> _offlineData = {};
  final List<SyncQueueItem> _syncQueue = [];
  final List<OfflineSession> _offlineSessions = [];

  // Getters
  List<SyncQueueItem> get syncQueue => List.unmodifiable(_syncQueue);
  List<OfflineSession> get offlineSessions => List.unmodifiable(_offlineSessions);
  int get pendingSyncCount => _syncQueue.where((e) => e.status == 'pending').length;

  // Add to sync queue
  Future<void> addToSyncQueue({
    required String endpoint,
    required String method,
    required Map<String, dynamic> payload,
    required String idempotencyKey,
  }) async {
    final item = SyncQueueItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      endpoint: endpoint,
      method: method,
      payload: payload,
      createdAt: DateTime.now(),
      idempotencyKey: idempotencyKey,
    );

    _syncQueue.add(item);
    notifyListeners();

    if (kDebugMode) {
      print('[OfflineStorage] Added to sync queue: $endpoint');
    }
  }

  // Mark item as synced
  Future<void> markAsSynced(String itemId) async {
    final index = _syncQueue.indexWhere((e) => e.id == itemId);
    if (index != -1) {
      final item = _syncQueue[index];
      _syncQueue[index] = SyncQueueItem(
        id: item.id,
        endpoint: item.endpoint,
        method: item.method,
        payload: item.payload,
        createdAt: item.createdAt,
        retryCount: item.retryCount,
        status: 'completed',
        idempotencyKey: item.idempotencyKey,
      );
      notifyListeners();
    }
  }

  // Mark item as failed
  Future<void> markAsFailed(String itemId, int retryCount) async {
    final index = _syncQueue.indexWhere((e) => e.id == itemId);
    if (index != -1) {
      final item = _syncQueue[index];
      _syncQueue[index] = SyncQueueItem(
        id: item.id,
        endpoint: item.endpoint,
        method: item.method,
        payload: item.payload,
        createdAt: item.createdAt,
        retryCount: retryCount,
        status: retryCount < 3 ? 'pending' : 'failed',
        idempotencyKey: item.idempotencyKey,
      );
      notifyListeners();
    }
  }

  // Save offline session
  Future<void> saveOfflineSession(OfflineSession session) async {
    _offlineSessions.add(session);
    notifyListeners();

    if (kDebugMode) {
      print('[OfflineStorage] Saved offline session: ${session.id}');
    }
  }

  // Get offline session
  OfflineSession? getOfflineSession(String id) {
    try {
      return _offlineSessions.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  // Clear completed items
  Future<void> clearCompleted() async {
    _syncQueue.removeWhere((e) => e.status == 'completed');
    notifyListeners();
  }

  // Get retry queue
  List<SyncQueueItem> getRetryQueue() {
    return _syncQueue.where((e) => e.status == 'pending').toList();
  }

  // Clear all
  Future<void> clearAll() async {
    _syncQueue.clear();
    _offlineSessions.clear();
    _offlineData.clear();
    notifyListeners();
  }
}
