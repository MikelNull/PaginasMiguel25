import 'package:cloud_firestore/cloud_firestore.dart';

/// Teacher-specific data stored in 'teachers/{teacherId}'.
class TeacherModel {
  final String id;
  final String uid; // References users/{uid}
  final String fullName;
  final String email;
  final String? phone;
  final String? subject;
  final String? photoUrl;
  final List<String> groupIds;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TeacherModel({
    required this.id,
    required this.uid,
    required this.fullName,
    required this.email,
    this.phone,
    this.subject,
    this.photoUrl,
    this.groupIds = const [],
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  int get groupCount => groupIds.length;
  bool get canCreateGroup => groupIds.length < 3;

  factory TeacherModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TeacherModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      subject: data['subject'],
      photoUrl: data['photoUrl'],
      groupIds: List<String>.from(data['groupIds'] ?? []),
      isActive: data['isActive'] ?? true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'subject': subject,
      'photoUrl': photoUrl,
      'groupIds': groupIds,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  TeacherModel copyWith({
    String? id,
    String? uid,
    String? fullName,
    String? email,
    String? phone,
    String? subject,
    String? photoUrl,
    List<String>? groupIds,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      photoUrl: photoUrl ?? this.photoUrl,
      groupIds: groupIds ?? this.groupIds,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
