import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ribaru_v2/features/auth/models/user.dart';
import 'package:ribaru_v2/core/services/email_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static Database? _database;
  static const String _usersTable = 'users';
  static const String _verificationTable = 'verification_tokens';
  final _emailService = EmailService();

  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<void> initialize() async {
    if (_database != null) return;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'auth.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_usersTable (
            id TEXT PRIMARY KEY,
            email TEXT UNIQUE,
            password_hash TEXT,
            name TEXT,
            business_name TEXT,
            is_verified BOOLEAN DEFAULT 0,
            role TEXT DEFAULT 'user',
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE $_verificationTable (
            token TEXT PRIMARY KEY,
            user_id TEXT,
            expires_at TEXT,
            FOREIGN KEY (user_id) REFERENCES $_usersTable (id)
          )
        ''');
      },
    );
  }

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required String businessName,
  }) async {
    await initialize();

    // Check if email already exists
    final existing = await _database!.query(
      _usersTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (existing.isNotEmpty) {
      throw Exception('Email already registered');
    }

    // Create user
    final user = User(
      id: _generateId(),
      email: email.toLowerCase(),
      name: name,
      businessName: businessName,
      isVerified: false,
      role: 'user',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Hash password
    final passwordHash = _hashPassword(password);

    // Save to database
    await _database!.insert(_usersTable, {
      ...user.toMap(),
      'password_hash': passwordHash,
    });

    // Generate and save verification token
    final token = await _createVerificationToken(user.id);

    // Send verification email
    await sendVerificationEmail(email, token);

    return user;
  }

  Future<User> login(String email, String password) async {
    await initialize();

    final results = await _database!.query(
      _usersTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (results.isEmpty) {
      throw Exception('Invalid email or password');
    }

    final user = User.fromMap(results.first);
    final storedHash = results.first['password_hash'] as String;

    if (_hashPassword(password) != storedHash) {
      throw Exception('Invalid email or password');
    }

    // Store session token
    final sessionToken = _generateSessionToken();
    await _storage.write(key: 'session_token', value: sessionToken);
    await _storage.write(key: 'user_id', value: user.id);

    return user;
  }

  Future<void> verifyEmail(String token) async {
    await initialize();

    final results = await _database!.query(
      _verificationTable,
      where: 'token = ?',
      whereArgs: [token],
    );

    if (results.isEmpty) {
      throw Exception('Invalid verification token');
    }

    final verification = results.first;
    final expiresAt = DateTime.parse(verification['expires_at'] as String);

    if (DateTime.now().isAfter(expiresAt)) {
      throw Exception('Verification token expired');
    }

    // Update user verification status
    await _database!.update(
      _usersTable,
      {'is_verified': 1},
      where: 'id = ?',
      whereArgs: [verification['user_id']],
    );

    // Delete used token
    await _database!.delete(
      _verificationTable,
      where: 'token = ?',
      whereArgs: [token],
    );
  }

  Future<void> resendVerification(String email) async {
    await initialize();

    final results = await _database!.query(
      _usersTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (results.isEmpty) {
      throw Exception('Email not found');
    }

    final user = User.fromMap(results.first);
    if (user.isVerified) {
      throw Exception('Email already verified');
    }

    // Delete existing tokens
    await _database!.delete(
      _verificationTable,
      where: 'user_id = ?',
      whereArgs: [user.id],
    );

    // Generate and save new token
    final token = await _createVerificationToken(user.id);

    // Send new verification email
    await sendVerificationEmail(email, token);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'session_token');
    await _storage.delete(key: 'user_id');
  }

  Future<User?> getCurrentUser() async {
    final userId = await _storage.read(key: 'user_id');
    if (userId == null) return null;

    await initialize();

    final results = await _database!.query(
      _usersTable,
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (results.isEmpty) return null;
    return User.fromMap(results.first);
  }

  Future<String> _createVerificationToken(String userId) async {
    final token = _generateToken();
    final expiresAt = DateTime.now().add(const Duration(hours: 24));

    await _database!.insert(_verificationTable, {
      'token': token,
      'user_id': userId,
      'expires_at': expiresAt.toIso8601String(),
    });

    return token;
  }

  Future<void> sendVerificationEmail(String email, String token) async {
    await _emailService.sendVerificationEmail(email, token);
  }

  Future<void> sendPasswordResetEmail(String email, String token) async {
    await _emailService.sendPasswordResetEmail(email, token);
  }

  Future<void> sendWelcomeEmail(String email, String name) async {
    await _emailService.sendWelcomeEmail(email, name);
  }

  String _generateId() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return sha256.convert(utf8.encode(random)).toString().substring(0, 32);
  }

  String _generateToken() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return sha256.convert(utf8.encode(random)).toString();
  }

  String _generateSessionToken() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return sha256.convert(utf8.encode(random)).toString();
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  // User Management Methods
  Future<List<User>> getAllUsers() async {
    await initialize();
    final List<Map<String, dynamic>> maps = await _database!.query(_usersTable);
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<void> updateUserRole(String userId, String newRole) async {
    await initialize();
    await _database!.update(
      _usersTable,
      {'role': newRole},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteUser(String userId) async {
    await initialize();
    await _database!.delete(
      _usersTable,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) async {
    // TODO: Implement actual email sending
    // For now, we'll just print the email details
    print('Sending email:');
    print('To: $to');
    print('Subject: $subject');
    print('Body: $body');
  }
}
