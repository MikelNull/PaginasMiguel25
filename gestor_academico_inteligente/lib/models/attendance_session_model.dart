import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/enums.dart';

/// Attendance session model stored in 'attendance_sessions/{sessionId}'.
class AttendanceSessionModel {
  final String id;
  final String groupId;
  final String teacherId;
  final DateTime date;
  final String? qrCode;
  final String? numericCode;
  final DateTime expiresAt;
  final bool isActive;
  final int presentCount;
  final int absentCount;
  final int pendingCount;
  final int totalStudents;
  final AttendanceMethod method;
  final DateTime createdAt;

  const AttendanceSessionModel({
    required this.id,
    required this.groupId,
    required this.teacherId,
    required this.date,
    this.qrCode,
    this.numericCode,
    required this.expiresAt,
    this.isActive = true,
    this.presentCount = 0,
    this.absentCount = 0,
    this.pendingCount = 0,
    this.totalStudents = 0,
    this.method = AttendanceMethod.qr,
    required this.createdAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  double get attendanceRate =>
      totalStudents > 0 ? presentCount / totalStudents : 0.0;

  factory AttendanceSessionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AttendanceSessionModel(
      id: doc.id,
      groupId: data['groupId'] ?? '',
      teacherId: data['teacherId'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      qrCode: data['qrCode'],
      numericCode: data['numericCode'],
      expiresAt:
          (data['expiresAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['isActive'] ?? true,
      presentCount: data['presentCount'] ?? 0,
      absentCount: data['absentCount'] ?? 0,
      pendingCount: data['pendingCount'] ?? 0,
      totalStudents: data['totalStudents'] ?? 0,
      method: AttendanceMethod.fromString(data['method'] ?? 'qr'),
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'groupId': groupId,
      'teacherId': teacherId,
      'date': Timestamp.fromDate(date),
      'qrCode': qrCode,
      'numericCode': numericCode,
      'expiresAt': Timestamp.fromDate(expiresAt),
      'isActive': isActive,
      'presentCount': presentCount,
      'absentCount': absentCount,
      'pendingCount': pendingCount,
      'totalStudents': totalStudents,
      'method': method.value,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  AttendanceSessionModel copyWith({
    String? id,
    String? groupId,
    String? teacherId,
    DateTime? date,
    String? qrCode,
    String? numericCode,
    DateTime? expiresAt,
    bool? isActive,
    int? presentCount,
    int? absentCount,
    int? pendingCount,
    int? totalStudents,
    AttendanceMethod? method,
    DateTime? createdAt,
  }) {
    return AttendanceSessionModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      teacherId: teacherId ?? this.teacherId,
      date: date ?? this.date,
      qrCode: qrCode ?? this.qrCode,
      numericCode: numericCode ?? this.numericCode,
      expiresAt: expiresAt ?? this.expiresAt,
      isActive: isActive ?? this.isActive,
      presentCount: presentCount ?? this.presentCount,
      absentCount: absentCount ?? this.absentCount,
      pendingCount: pendingCount ?? this.pendingCount,
      totalStudents: totalStudents ?? this.totalStudents,
      method: method ?? this.method,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// Individual attendance record for a student in a session.
class AttendanceRecordModel {
  final String id;
  final String sessionId;
  final String studentId;
  final String studentName;
  final int listNumber;
  final AttendanceStatus status;
  final AttendanceMethod method;
  final DateTime? markedAt;
  final String? notes;

  const AttendanceRecordModel({
    required this.id,
    required this.sessionId,
    required this.studentId,
    required this.studentName,
    required this.listNumber,
    this.status = AttendanceStatus.absent,
    this.method = AttendanceMethod.manual,
    this.markedAt,
    this.notes,
  });

  factory AttendanceRecordModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AttendanceRecordModel(
      id: doc.id,
      sessionId: data['sessionId'] ?? '',
      studentId: data['studentId'] ?? '',
      studentName: data['studentName'] ?? '',
      listNumber: data['listNumber'] ?? 0,
      status: AttendanceStatus.fromString(data['status'] ?? 'absent'),
      method: AttendanceMethod.fromString(data['method'] ?? 'manual'),
      markedAt: (data['markedAt'] as Timestamp?)?.toDate(),
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'sessionId': sessionId,
      'studentId': studentId,
      'studentName': studentName,
      'listNumber': listNumber,
      'status': status.value,
      'method': method.value,
      'markedAt': markedAt != null ? Timestamp.fromDate(markedAt!) : null,
      'notes': notes,
    };
  }

  AttendanceRecordModel copyWith({
    String? id,
    String? sessionId,
    String? studentId,
    String? studentName,
    int? listNumber,
    AttendanceStatus? status,
    AttendanceMethod? method,
    DateTime? markedAt,
    String? notes,
  }) {
    return AttendanceRecordModel(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      listNumber: listNumber ?? this.listNumber,
      status: status ?? this.status,
      method: method ?? this.method,
      markedAt: markedAt ?? this.markedAt,
      notes: notes ?? this.notes,
    );
  }
}
