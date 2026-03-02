import 'package:cloud_firestore/cloud_firestore.dart';

/// Group model stored in 'groups/{groupId}'.
class GroupModel {
  final String id;
  final String name; // e.g., "3°A"
  final String teacherId;
  final String teacherName;
  final String? subject;
  final List<String> studentIds;
  final int studentCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GroupModel({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.teacherName,
    this.subject,
    this.studentIds = const [],
    this.studentCount = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GroupModel(
      id: doc.id,
      name: data['name'] ?? '',
      teacherId: data['teacherId'] ?? '',
      teacherName: data['teacherName'] ?? '',
      subject: data['subject'],
      studentIds: List<String>.from(data['studentIds'] ?? []),
      studentCount: data['studentCount'] ?? 0,
      isActive: data['isActive'] ?? true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'subject': subject,
      'studentIds': studentIds,
      'studentCount': studentIds.length,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  GroupModel copyWith({
    String? id,
    String? name,
    String? teacherId,
    String? teacherName,
    String? subject,
    List<String>? studentIds,
    int? studentCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      subject: subject ?? this.subject,
      studentIds: studentIds ?? this.studentIds,
      studentCount: studentCount ?? this.studentCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
