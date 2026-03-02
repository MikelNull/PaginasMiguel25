/// Firestore collection and document path constants.
class FirestorePaths {
  FirestorePaths._();

  // Top-level collections
  static const String users = 'users';
  static const String admins = 'admins';
  static const String teachers = 'teachers';
  static const String students = 'students';
  static const String groups = 'groups';
  static const String evaluations = 'evaluations';
  static const String submissions = 'submissions';
  static const String attendanceSessions = 'attendance_sessions';
  static const String reports = 'reports';
  static const String auditLogs = 'audit_logs';

  // Document paths
  static String user(String uid) => '$users/$uid';
  static String admin(String adminId) => '$admins/$adminId';
  static String teacher(String teacherId) => '$teachers/$teacherId';
  static String student(String studentId) => '$students/$studentId';
  static String group(String groupId) => '$groups/$groupId';
  static String evaluation(String evalId) => '$evaluations/$evalId';
  static String submission(String subId) => '$submissions/$subId';
  static String attendanceSession(String sessionId) =>
      '$attendanceSessions/$sessionId';
  static String report(String reportId) => '$reports/$reportId';
  static String auditLog(String logId) => '$auditLogs/$logId';

  // Sub-collection paths
  static String groupStudents(String groupId) => '$groups/$groupId/students';
  static String attendanceRecords(String sessionId) =>
      '$attendanceSessions/$sessionId/records';
}
