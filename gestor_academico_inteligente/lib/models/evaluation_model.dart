import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/enums.dart';

/// Evaluation model stored in 'evaluations/{evalId}'.
class EvaluationModel {
  final String id;
  final String groupId;
  final String teacherId;
  final String title;
  final String? description;
  final EvaluationType type;
  final double weight; // 0.0 to 1.0
  final int parcial; // 1, 2, or 3
  final DateTime? dueDate;
  final RubricModel? rubric;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EvaluationModel({
    required this.id,
    required this.groupId,
    required this.teacherId,
    required this.title,
    this.description,
    required this.type,
    required this.weight,
    required this.parcial,
    this.dueDate,
    this.rubric,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EvaluationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EvaluationModel(
      id: doc.id,
      groupId: data['groupId'] ?? '',
      teacherId: data['teacherId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'],
      type: EvaluationType.fromString(data['type'] ?? 'exam'),
      weight: (data['weight'] ?? 0.0).toDouble(),
      parcial: data['parcial'] ?? 1,
      dueDate: (data['dueDate'] as Timestamp?)?.toDate(),
      rubric: data['rubric'] != null
          ? RubricModel.fromMap(data['rubric'] as Map<String, dynamic>)
          : null,
      isActive: data['isActive'] ?? true,
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt:
          (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'groupId': groupId,
      'teacherId': teacherId,
      'title': title,
      'description': description,
      'type': type.value,
      'weight': weight,
      'parcial': parcial,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'rubric': rubric?.toMap(),
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  EvaluationModel copyWith({
    String? id,
    String? groupId,
    String? teacherId,
    String? title,
    String? description,
    EvaluationType? type,
    double? weight,
    int? parcial,
    DateTime? dueDate,
    RubricModel? rubric,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EvaluationModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      teacherId: teacherId ?? this.teacherId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      weight: weight ?? this.weight,
      parcial: parcial ?? this.parcial,
      dueDate: dueDate ?? this.dueDate,
      rubric: rubric ?? this.rubric,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Rubric for evaluation criteria.
class RubricModel {
  final String name;
  final List<RubricCriterion> criteria;

  const RubricModel({
    required this.name,
    required this.criteria,
  });

  factory RubricModel.fromMap(Map<String, dynamic> map) {
    return RubricModel(
      name: map['name'] ?? '',
      criteria: (map['criteria'] as List<dynamic>?)
              ?.map((c) => RubricCriterion.fromMap(c as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'criteria': criteria.map((c) => c.toMap()).toList(),
    };
  }
}

/// Individual criterion within a rubric.
class RubricCriterion {
  final String name;
  final String description;
  final double maxScore;
  final double weight; // Weight within this rubric

  const RubricCriterion({
    required this.name,
    required this.description,
    required this.maxScore,
    required this.weight,
  });

  factory RubricCriterion.fromMap(Map<String, dynamic> map) {
    return RubricCriterion(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      maxScore: (map['maxScore'] ?? 10.0).toDouble(),
      weight: (map['weight'] ?? 1.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'maxScore': maxScore,
      'weight': weight,
    };
  }
}
