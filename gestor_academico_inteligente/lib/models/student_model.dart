import 'package:cloud_firestore/cloud_firestore.dart';

/// Student-specific data stored in 'students/{studentId}'.
class StudentModel {
  final String id;
  final String uid; // References users/{uid}
  final String fullName;
  final String email;
  final String matricula;
  final int listNumber; // Número de lista
  final String? groupId;
  final String? groupName;
  final String? teacherId;
  final String? photoUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Encrypted fields note: fullName, matricula, and grades are
  // encrypted at rest using AES-256.

  const StudentModel({
    required this.id,
    required this.uid,
    required this.fullName,
    required this.email,
    required this.matricula,
    required this.listNumber,
    this.groupId,
    this.groupName,
    this.teacherId,
    this.photoUrl,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StudentModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      matricula: data['matricula'] ?? '',
      listNumber: data['listNumber'] ?? 0,
      groupId: data['groupId'],
      groupName: data['groupName'],
      teacherId: data['teacherId'],
      photoUrl: data['photoUrl'],
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
      'matricula': matricula,
      'listNumber': listNumber,
      'groupId': groupId,
      'groupName': groupName,
      'teacherId': teacherId,
      'photoUrl': photoUrl,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  StudentModel copyWith({
    String? id,
    String? uid,
    String? fullName,
    String? email,
    String? matricula,
    int? listNumber,
    String? groupId,
    String? groupName,
    String? teacherId,
    String? photoUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      matricula: matricula ?? this.matricula,
      listNumber: listNumber ?? this.listNumber,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      teacherId: teacherId ?? this.teacherId,
      photoUrl: photoUrl ?? this.photoUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
