import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/enums.dart';

/// Weekly report model stored in 'reports/{reportId}'.
class ReportModel {
  final String id;
  final String groupId;
  final String groupName;
  final String teacherId;
  final DateTime weekStart;
  final DateTime weekEnd;
  final int totalStudents;
  final double weeklyAttendanceRate;
  final double generalAverage;
  final List<StudentRiskInfo> studentsAtRisk;
  final GroupHealthInfo healthInfo;
  final String? pdfUrl;
  final DateTime createdAt;

  const ReportModel({
    required this.id,
    required this.groupId,
    required this.groupName,
    required this.teacherId,
    required this.weekStart,
    required this.weekEnd,
    required this.totalStudents,
    required this.weeklyAttendanceRate,
    required this.generalAverage,
    this.studentsAtRisk = const [],
    required this.healthInfo,
    this.pdfUrl,
    required this.createdAt,
  });

  factory ReportModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      id: doc.id,
      groupId: data['groupId'] ?? '',
      groupName: data['groupName'] ?? '',
      teacherId: data['teacherId'] ?? '',
      weekStart:
          (data['weekStart'] as Timestamp?)?.toDate() ?? DateTime.now(),
      weekEnd: (data['weekEnd'] as Timestamp?)?.toDate() ?? DateTime.now(),
      totalStudents: data['totalStudents'] ?? 0,
      weeklyAttendanceRate:
          (data['weeklyAttendanceRate'] ?? 0.0).toDouble(),
      generalAverage: (data['generalAverage'] ?? 0.0).toDouble(),
      studentsAtRisk: (data['studentsAtRisk'] as List<dynamic>?)
              ?.map((s) =>
                  StudentRiskInfo.fromMap(s as Map<String, dynamic>))
              .toList() ??
          [],
      healthInfo: data['healthInfo'] != null
          ? GroupHealthInfo.fromMap(
              data['healthInfo'] as Map<String, dynamic>)
          : const GroupHealthInfo(),
      pdfUrl: data['pdfUrl'],
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'teacherId': teacherId,
      'weekStart': Timestamp.fromDate(weekStart),
      'weekEnd': Timestamp.fromDate(weekEnd),
      'totalStudents': totalStudents,
      'weeklyAttendanceRate': weeklyAttendanceRate,
      'generalAverage': generalAverage,
      'studentsAtRisk': studentsAtRisk.map((s) => s.toMap()).toList(),
      'healthInfo': healthInfo.toMap(),
      'pdfUrl': pdfUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

/// Risk information for a specific student.
class StudentRiskInfo {
  final String studentId;
  final String studentName;
  final int listNumber;
  final double attendanceRate;
  final int consecutiveAbsences;
  final double average;
  final double averageChange; // positive = improvement, negative = decline
  final RiskLevel riskLevel;
  final String recommendation;

  const StudentRiskInfo({
    required this.studentId,
    required this.studentName,
    required this.listNumber,
    required this.attendanceRate,
    this.consecutiveAbsences = 0,
    required this.average,
    this.averageChange = 0.0,
    required this.riskLevel,
    this.recommendation = '',
  });

  factory StudentRiskInfo.fromMap(Map<String, dynamic> map) {
    return StudentRiskInfo(
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      listNumber: map['listNumber'] ?? 0,
      attendanceRate: (map['attendanceRate'] ?? 0.0).toDouble(),
      consecutiveAbsences: map['consecutiveAbsences'] ?? 0,
      average: (map['average'] ?? 0.0).toDouble(),
      averageChange: (map['averageChange'] ?? 0.0).toDouble(),
      riskLevel: RiskLevel.fromString(map['riskLevel'] ?? 'healthy'),
      recommendation: map['recommendation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'listNumber': listNumber,
      'attendanceRate': attendanceRate,
      'consecutiveAbsences': consecutiveAbsences,
      'average': average,
      'averageChange': averageChange,
      'riskLevel': riskLevel.value,
      'recommendation': recommendation,
    };
  }
}

/// Overall health information for a group.
class GroupHealthInfo {
  final double healthyPercentage;
  final double atRiskPercentage;
  final double criticalPercentage;
  final int healthyCount;
  final int atRiskCount;
  final int criticalCount;

  const GroupHealthInfo({
    this.healthyPercentage = 0.0,
    this.atRiskPercentage = 0.0,
    this.criticalPercentage = 0.0,
    this.healthyCount = 0,
    this.atRiskCount = 0,
    this.criticalCount = 0,
  });

  factory GroupHealthInfo.fromMap(Map<String, dynamic> map) {
    return GroupHealthInfo(
      healthyPercentage: (map['healthyPercentage'] ?? 0.0).toDouble(),
      atRiskPercentage: (map['atRiskPercentage'] ?? 0.0).toDouble(),
      criticalPercentage: (map['criticalPercentage'] ?? 0.0).toDouble(),
      healthyCount: map['healthyCount'] ?? 0,
      atRiskCount: map['atRiskCount'] ?? 0,
      criticalCount: map['criticalCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'healthyPercentage': healthyPercentage,
      'atRiskPercentage': atRiskPercentage,
      'criticalPercentage': criticalPercentage,
      'healthyCount': healthyCount,
      'atRiskCount': atRiskCount,
      'criticalCount': criticalCount,
    };
  }
}
