import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/audit_log_model.dart';
import '../../core/constants/enums.dart';
import '../../core/constants/firestore_paths.dart';

/// Service for recording audit logs of all significant actions.
/// Only Admin can read audit logs.
class AuditService {
  final FirebaseFirestore _firestore;

  AuditService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Log an audit action.
  Future<void> log({
    required String userId,
    required String userEmail,
    required UserRole userRole,
    required AuditAction action,
    required String description,
    String? targetId,
    String? targetType,
    Map<String, dynamic>? metadata,
  }) async {
    final docRef = _firestore.collection(FirestorePaths.auditLogs).doc();
    final auditLog = AuditLogModel(
      id: docRef.id,
      userId: userId,
      userEmail: userEmail,
      userRole: userRole,
      action: action,
      description: description,
      targetId: targetId,
      targetType: targetType,
      metadata: metadata,
      createdAt: DateTime.now(),
    );
    await docRef.set(auditLog.toFirestore());
  }

  /// Get audit logs with pagination.
  Future<List<AuditLogModel>> getLogs({
    int limit = 50,
    DocumentSnapshot? lastDocument,
    AuditAction? filterAction,
    String? filterUserId,
  }) async {
    Query query = _firestore
        .collection(FirestorePaths.auditLogs)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (filterAction != null) {
      query = query.where('action', isEqualTo: filterAction.value);
    }
    if (filterUserId != null) {
      query = query.where('userId', isEqualTo: filterUserId);
    }
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }

  /// Get logs for a specific date range.
  Future<List<AuditLogModel>> getLogsByDateRange({
    required DateTime start,
    required DateTime end,
    int limit = 100,
  }) async {
    final snapshot = await _firestore
        .collection(FirestorePaths.auditLogs)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => AuditLogModel.fromFirestore(doc)).toList();
  }
}
