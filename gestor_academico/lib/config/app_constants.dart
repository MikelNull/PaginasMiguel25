/// Application-wide constants for the Gestor Academico Inteligente.
class AppConstants {
  AppConstants._();

  // --- App Info ---
  static const String appName = 'Gestor Academico';
  static const String appVersion = '1.0.0';

  // --- Role Identifiers ---
  static const String roleAdmin = 'admin';
  static const String roleTeacher = 'teacher';
  static const String roleStudent = 'student';

  // --- Limits ---
  static const int maxGroupsPerTeacher = 3;
  static const int maxStudentsPerGroup = 100;
  static const int maxTeachersInitial = 5;
  static const int maxStudentsInitial = 100;
  static const int paginationPageSize = 20;
  static const int batchWriteSize = 500;

  // --- QR / Attendance ---
  static const int qrValidityMinutes = 5;
  static const int numericCodeLength = 6;
  static const double qrMinSize = 300.0;
  static const int attendanceQrExpirationMs = 5 * 60 * 1000;

  // --- Evaluation Types ---
  static const String evalExam = 'exam';
  static const String evalPractice = 'practice';
  static const String evalParticipation = 'participation';
  static const String evalProject = 'project';

  // --- Default Weights ---
  static const Map<String, double> defaultEvalWeights = {
    evalExam: 0.40,
    evalPractice: 0.30,
    evalParticipation: 0.20,
    evalProject: 0.10,
  };

  // --- Evaluation Type Labels (Spanish) ---
  static const Map<String, String> evalTypeLabels = {
    evalExam: 'Examen',
    evalPractice: 'Practica',
    evalParticipation: 'Participacion',
    evalProject: 'Proyecto',
  };

  // --- Attendance Status ---
  static const String attendancePresent = 'present';
  static const String attendancePending = 'pending';
  static const String attendanceAbsent = 'absent';

  // --- Image Constraints ---
  static const int maxImageSizeKB = 100;
  static const String imageFormat = 'webp';

  // --- Firestore Collections ---
  static const String colUsers = 'users';
  static const String colAdmins = 'admins';
  static const String colTeachers = 'teachers';
  static const String colStudents = 'students';
  static const String colGroups = 'groups';
  static const String colEvaluations = 'evaluations';
  static const String colSubmissions = 'submissions';
  static const String colAttendanceSessions = 'attendance_sessions';
  static const String colReports = 'reports';
  static const String colAuditLogs = 'audit_logs';

  // --- Risk Thresholds ---
  static const double attendanceRiskThreshold = 0.70;
  static const double attendanceCriticalThreshold = 0.50;
  static const double gradeRiskThreshold = 7.0;
  static const int consecutiveAbsenceAlert = 3;

  // --- Animation Durations ---
  static const int animValidateMs = 200;
  static const int animMarkAttendanceMs = 300;
  static const int animSkeletonFadeMs = 400;
  static const int animNotificationBounceMs = 500;
}
