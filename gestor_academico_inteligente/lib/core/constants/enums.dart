/// All enums used across the application.

/// User roles in the system.
enum UserRole {
  admin('admin', 'Administrador'),
  teacher('teacher', 'Maestro'),
  student('student', 'Estudiante');

  const UserRole(this.value, this.displayName);
  final String value;
  final String displayName;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.student,
    );
  }
}

/// Attendance status for a student in a session.
enum AttendanceStatus {
  present('present', 'Presente', '✓'),
  absent('absent', 'Ausente', '✗'),
  pending('pending', 'Pendiente', '⚠'),
  late_('late', 'Retardo', '⏰'),
  justified('justified', 'Justificado', '📋');

  const AttendanceStatus(this.value, this.displayName, this.icon);
  final String value;
  final String displayName;
  final String icon;

  static AttendanceStatus fromString(String value) {
    return AttendanceStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => AttendanceStatus.absent,
    );
  }
}

/// Types of evaluations available.
enum EvaluationType {
  exam('exam', 'Examen', 0.40),
  practice('practice', 'Práctica', 0.30),
  participation('participation', 'Participación', 0.20),
  project('project', 'Proyecto', 0.10);

  const EvaluationType(this.value, this.displayName, this.defaultWeight);
  final String value;
  final String displayName;
  final double defaultWeight;

  static EvaluationType fromString(String value) {
    return EvaluationType.values.firstWhere(
      (t) => t.value == value,
      orElse: () => EvaluationType.exam,
    );
  }
}

/// Status of a submission.
enum SubmissionStatus {
  pending('pending', 'Pendiente'),
  submitted('submitted', 'Entregado'),
  graded('graded', 'Calificado'),
  aiSuggested('ai_suggested', 'Sugerido por IA'),
  approved('approved', 'Aprobado'),
  rejected('rejected', 'Rechazado');

  const SubmissionStatus(this.value, this.displayName);
  final String value;
  final String displayName;

  static SubmissionStatus fromString(String value) {
    return SubmissionStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => SubmissionStatus.pending,
    );
  }
}

/// Risk level for students.
enum RiskLevel {
  healthy('healthy', 'Saludable'),
  atRisk('at_risk', 'En Riesgo'),
  critical('critical', 'Crítico');

  const RiskLevel(this.value, this.displayName);
  final String value;
  final String displayName;

  static RiskLevel fromString(String value) {
    return RiskLevel.values.firstWhere(
      (l) => l.value == value,
      orElse: () => RiskLevel.healthy,
    );
  }
}

/// Type of audit log action.
enum AuditAction {
  login('login'),
  logout('logout'),
  createUser('create_user'),
  updateUser('update_user'),
  deleteUser('delete_user'),
  createGroup('create_group'),
  updateGroup('update_group'),
  deleteGroup('delete_group'),
  createEvaluation('create_evaluation'),
  gradeSubmission('grade_submission'),
  generateReport('generate_report'),
  markAttendance('mark_attendance'),
  systemConfig('system_config');

  const AuditAction(this.value);
  final String value;

  static AuditAction fromString(String value) {
    return AuditAction.values.firstWhere(
      (a) => a.value == value,
      orElse: () => AuditAction.login,
    );
  }
}

/// Day of the week (Spanish).
enum DayOfWeek {
  monday('L', 'Lunes'),
  tuesday('M', 'Martes'),
  wednesday('X', 'Miércoles'),
  thursday('J', 'Jueves'),
  friday('V', 'Viernes');

  const DayOfWeek(this.shortName, this.fullName);
  final String shortName;
  final String fullName;
}

/// Attendance method used.
enum AttendanceMethod {
  qr('qr', 'Código QR'),
  numericCode('numeric_code', 'Código Numérico'),
  manual('manual', 'Manual');

  const AttendanceMethod(this.value, this.displayName);
  final String value;
  final String displayName;

  static AttendanceMethod fromString(String value) {
    return AttendanceMethod.values.firstWhere(
      (m) => m.value == value,
      orElse: () => AttendanceMethod.manual,
    );
  }
}
