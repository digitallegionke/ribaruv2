import 'package:sqflite/sqflite.dart';
import 'package:ribaru_v2/features/auth/models/user.dart';
import 'package:ribaru_v2/features/auth/services/auth_service.dart';

class AuditService {
  static final AuditService _instance = AuditService._internal();
  factory AuditService() => _instance;
  AuditService._internal();

  static const String _auditTable = 'audit_logs';
  Database? _database;

  Future<void> initialize() async {
    if (_database != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ribaru.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $_auditTable (
            id TEXT PRIMARY KEY,
            action TEXT NOT NULL,
            performed_by TEXT NOT NULL,
            target_user TEXT,
            details TEXT,
            timestamp INTEGER NOT NULL,
            FOREIGN KEY (performed_by) REFERENCES users (id),
            FOREIGN KEY (target_user) REFERENCES users (id)
          )
        ''');
      },
    );
  }

  Future<void> logUserAction({
    required String action,
    required String performedBy,
    String? targetUser,
    Map<String, dynamic>? details,
  }) async {
    await initialize();

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final id = _generateId();

    await _database!.insert(
      _auditTable,
      {
        'id': id,
        'action': action,
        'performed_by': performedBy,
        'target_user': targetUser,
        'details': details != null ? _encodeDetails(details) : null,
        'timestamp': timestamp,
      },
    );
  }

  Future<List<AuditLog>> getAuditLogs({
    String? action,
    String? performedBy,
    String? targetUser,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 100,
    int offset = 0,
  }) async {
    await initialize();

    String whereClause = '1=1';
    List<dynamic> whereArgs = [];

    if (action != null) {
      whereClause += ' AND action = ?';
      whereArgs.add(action);
    }

    if (performedBy != null) {
      whereClause += ' AND performed_by = ?';
      whereArgs.add(performedBy);
    }

    if (targetUser != null) {
      whereClause += ' AND target_user = ?';
      whereArgs.add(targetUser);
    }

    if (startDate != null) {
      whereClause += ' AND timestamp >= ?';
      whereArgs.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      whereClause += ' AND timestamp <= ?';
      whereArgs.add(endDate.millisecondsSinceEpoch);
    }

    final logs = await _database!.query(
      _auditTable,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'timestamp DESC',
      limit: limit,
      offset: offset,
    );

    return Future.wait(logs.map((log) => _createAuditLog(log)));
  }

  Future<AuditLog> _createAuditLog(Map<String, dynamic> data) async {
    final performedByUser = await AuthService().getUserById(data['performed_by']);
    final targetUser = data['target_user'] != null
        ? await AuthService().getUserById(data['target_user'])
        : null;

    return AuditLog(
      id: data['id'],
      action: data['action'],
      performedBy: performedByUser,
      targetUser: targetUser,
      details: data['details'] != null ? _decodeDetails(data['details']) : null,
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }

  String _generateId() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return sha256.convert(utf8.encode(random)).toString().substring(0, 32);
  }

  String _encodeDetails(Map<String, dynamic> details) {
    return jsonEncode(details);
  }

  Map<String, dynamic> _decodeDetails(String details) {
    return jsonDecode(details);
  }
}

class AuditLog {
  final String id;
  final String action;
  final User performedBy;
  final User? targetUser;
  final Map<String, dynamic>? details;
  final DateTime timestamp;

  const AuditLog({
    required this.id,
    required this.action,
    required this.performedBy,
    this.targetUser,
    this.details,
    required this.timestamp,
  });

  String get formattedTimestamp {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} '
        '${timestamp.hour}:${timestamp.minute}:${timestamp.second}';
  }

  String get actionDescription {
    switch (action) {
      case 'user_created':
        return 'Created user';
      case 'user_deleted':
        return 'Deleted user';
      case 'role_updated':
        return 'Updated user role to ${details?['new_role']}';
      case 'verification_status_updated':
        return 'Updated verification status';
      case 'password_reset':
        return 'Reset password';
      case 'login_attempt':
        return details?['success'] == true
            ? 'Successful login'
            : 'Failed login attempt';
      default:
        return action;
    }
  }
}
