import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/enums.dart';

/// Audit log model stored in 'audit_logs/{logId}'.
class AuditLogModel {
  final String id;
  final String userId;
  final String userEmail;
  final UserRole userRole;
  final AuditAction action;
  final String description;
  final Map<String, dynamic>? metadata;
  final String? targetId;
  final String? targetType;
  final DateTime createdAt;

  const AuditLogModel({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.userRole,
    required this.action,
    required this.description,
    this.metadata,
    this.targetId,
    this.targetType,
    required this.createdAt,
  });

  factory AuditLogModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AuditLogModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      userEmail: data['userEmail'] ?? '',
      userRole: UserRole.fromString(data['userRole'] ?? 'student'),
      action: AuditAction.fromString(data['action'] ?? 'login'),
      description: data['description'] ?? '',
      metadata: data['metadata'] as Map<String, dynamic>?,
      targetId: data['targetId'],
      targetType: data['targetType'],
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'userRole': userRole.value,
      'action': action.value,
      'description': description,
      'metadata': metadata,
      'targetId': targetId,
      'targetType': targetType,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
