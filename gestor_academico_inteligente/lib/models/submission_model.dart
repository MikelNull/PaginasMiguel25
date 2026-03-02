import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/enums.dart';

/// Submission model stored in 'submissions/{submissionId}'.
class SubmissionModel {
  final String id;
  final String evaluationId;
  final String studentId;
  final String studentName;
  final String groupId;
  final String teacherId;
  final SubmissionStatus status;
  final String? content; // Text content
  final String? fileUrl; // PDF/image URL
  final String? fileType; // pdf, image, text
  final double? aiSuggestedGrade;
  final String? aiFeedback;
  final double? finalGrade;
  final String? teacherFeedback;
  final Map<String, double>? criteriaScores; // Rubric criterion -> score
  final DateTime? submittedAt;
  final DateTime? gradedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubmissionModel({
    required this.id,
    required this.evaluationId,
    required this.studentId,
    required this.studentName,
    required this.groupId,
    required this.teacherId,
    this.status = SubmissionStatus.pending,
    this.content,
    this.fileUrl,
    this.fileType,
    this.aiSuggestedGrade,
    this.aiFeedback,
    this.finalGrade,
    this.teacherFeedback,
    this.criteriaScores,
    this.submittedAt,
    this.gradedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isGraded =>
      status == SubmissionStatus.graded || status == SubmissionStatus.approved;
  bool get hasAiSuggestion => aiSuggestedGrade != null;

  factory SubmissionModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubmissionModel(
      id: doc.id,
      evaluationId: data['evaluationId'] ?? '',
      studentId: data['studentId'] ?? '',
      studentName: data['studentName'] ?? '',
      groupId: data['groupId'] ?? '',
      teacherId: data['teacherId'] ?? '',
      status: SubmissionStatus.fromString(data['status'] ?? 'pending'),
      content: data['content'],
      fileUrl: data['fileUrl'],
      fileType: data['fileType'],
      aiSuggestedGrade: (data['aiSuggestedGrade'] as num?)?.toDouble(),
      aiFeedback: data['aiFeedback'],
      finalGrade: (data['finalGrade'] as num?)?.toDouble(),
      teacherFeedback: data['teacherFeedback'],
      criteriaScores: data['criteriaScores'] != null
          ? Map<String, double>.from(
              (data['criteriaScores'] as Map).map(
                (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
              ),
            )
          : null,
      submittedAt: (data['submittedAt'] as Timestamp?)?.toDate(),
      gradedAt: (data['gradedAt'] as Timestamp?)?.toDate(),
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'evaluationId': evaluationId,
      'studentId': studentId,
      'studentName': studentName,
      'groupId': groupId,
      'teacherId': teacherId,
      'status': status.value,
      'content': content,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'aiSuggestedGrade': aiSuggestedGrade,
      'aiFeedback': aiFeedback,
      'finalGrade': finalGrade,
      'teacherFeedback': teacherFeedback,
      'criteriaScores': criteriaScores,
      'submittedAt':
          submittedAt != null ? Timestamp.fromDate(submittedAt!) : null,
      'gradedAt': gradedAt != null ? Timestamp.fromDate(gradedAt!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  SubmissionModel copyWith({
    String? id,
    String? evaluationId,
    String? studentId,
    String? studentName,
    String? groupId,
    String? teacherId,
    SubmissionStatus? status,
    String? content,
    String? fileUrl,
    String? fileType,
    double? aiSuggestedGrade,
    String? aiFeedback,
    double? finalGrade,
    String? teacherFeedback,
    Map<String, double>? criteriaScores,
    DateTime? submittedAt,
    DateTime? gradedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubmissionModel(
      id: id ?? this.id,
      evaluationId: evaluationId ?? this.evaluationId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      groupId: groupId ?? this.groupId,
      teacherId: teacherId ?? this.teacherId,
      status: status ?? this.status,
      content: content ?? this.content,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      aiSuggestedGrade: aiSuggestedGrade ?? this.aiSuggestedGrade,
      aiFeedback: aiFeedback ?? this.aiFeedback,
      finalGrade: finalGrade ?? this.finalGrade,
      teacherFeedback: teacherFeedback ?? this.teacherFeedback,
      criteriaScores: criteriaScores ?? this.criteriaScores,
      submittedAt: submittedAt ?? this.submittedAt,
      gradedAt: gradedAt ?? this.gradedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
