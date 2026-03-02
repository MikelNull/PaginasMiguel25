/// Application-wide constants for the Gestor Académico Inteligente.
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Gestor Académico Inteligente';
  static const String appVersion = '1.0.0';

  // Role limits
  static const int maxTeachers = 5;
  static const int maxStudents = 100;
  static const int maxGroupsPerTeacher = 3;
  static const int maxStudentsPerGroup = 40;

  // QR & Attendance
  static const int qrValidityMinutes = 5;
  static const int numericCodeLength = 6;
  static const int qrMinSize = 300; // pixels
  static const Duration qrExpiration = Duration(minutes: 5);

  // Pagination
  static const int studentsPerPage = 20;
  static const int defaultPageSize = 20;

  // Performance targets
  static const Duration maxActionTime = Duration(seconds: 3);
  static const Duration maxListLoadTime = Duration(milliseconds: 1200);

  // File limits
  static const int maxImageSizeKB = 100;
  static const int maxPdfSizeMB = 10;

  // Firestore batch limits
  static const int firestoreBatchSize = 500;

  // Evaluation weights (defaults)
  static const double defaultExamWeight = 0.40;
  static const double defaultPracticeWeight = 0.30;
  static const double defaultParticipationWeight = 0.20;
  static const double defaultProjectWeight = 0.10;

  // Grade scale
  static const double minGrade = 0.0;
  static const double maxGrade = 10.0;
  static const double passingGrade = 6.0;

  // Risk thresholds
  static const double attendanceRiskThreshold = 0.60; // 60%
  static const double gradeRiskThreshold = 6.5;
  static const int consecutiveAbsenceAlert = 3;

  // Parciales
  static const int totalParciales = 3;

  // Cache durations
  static const Duration rubricCacheDuration = Duration(days: 7);
  static const Duration reportCacheDuration = Duration(hours: 24);

  // Animation durations
  static const Duration microInteractionDuration = Duration(milliseconds: 200);
  static const Duration buttonExpandDuration = Duration(milliseconds: 300);
  static const Duration skeletonFadeDuration = Duration(milliseconds: 400);
  static const Duration badgeBounceDuration = Duration(milliseconds: 500);
}
