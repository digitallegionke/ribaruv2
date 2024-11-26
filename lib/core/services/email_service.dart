import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';

class EmailService {
  static final EmailService _instance = EmailService._internal();
  factory EmailService() => _instance;
  EmailService._internal();

  final _storage = const FlutterSecureStorage();
  
  SmtpServer? _smtpServer;
  AwsSigV4Client? _sesClient;

  Future<void> initialize() async {
    final emailProvider = await _storage.read(key: 'email_provider') ?? 'smtp';
    
    if (emailProvider == 'ses') {
      await _initializeSES();
    } else {
      await _initializeSMTP();
    }
  }

  Future<void> _initializeSMTP() async {
    final host = await _storage.read(key: 'smtp_host') ?? 'smtp.gmail.com';
    final port = int.parse(await _storage.read(key: 'smtp_port') ?? '587');
    final username = await _storage.read(key: 'smtp_username');
    final password = await _storage.read(key: 'smtp_password');

    if (username == null || password == null) {
      throw Exception('SMTP credentials not configured');
    }

    _smtpServer = SmtpServer(
      host,
      port: port,
      username: username,
      password: password,
      ssl: port == 465,
      allowInsecure: false,
    );
  }

  Future<void> _initializeSES() async {
    final accessKey = await _storage.read(key: 'aws_access_key');
    final secretKey = await _storage.read(key: 'aws_secret_key');
    final region = await _storage.read(key: 'aws_region') ?? 'us-east-1';

    if (accessKey == null || secretKey == null) {
      throw Exception('AWS credentials not configured');
    }

    _sesClient = AwsSigV4Client(
      accessKey,
      secretKey,
      'https://email.$region.amazonaws.com',
      region: region,
    );
  }

  Future<void> sendEmail({
    required String to,
    required String subject,
    required String body,
    bool isHtml = false,
    List<String> cc = const [],
    List<String> bcc = const [],
    List<Attachment> attachments = const [],
  }) async {
    final fromEmail = await _storage.read(key: 'from_email');
    final fromName = await _storage.read(key: 'from_name') ?? 'Ribaru';

    if (fromEmail == null) {
      throw Exception('Sender email not configured');
    }

    final message = Message()
      ..from = Address(fromEmail, fromName)
      ..recipients.add(to)
      ..ccRecipients.addAll(cc)
      ..bccRecipients.addAll(bcc)
      ..subject = subject
      ..attachments.addAll(attachments);

    if (isHtml) {
      message.html = body;
    } else {
      message.text = body;
    }

    try {
      if (_sesClient != null) {
        await _sendViaSES(message);
      } else if (_smtpServer != null) {
        await send(message, _smtpServer!);
      } else {
        throw Exception('Email service not initialized');
      }
    } catch (e) {
      throw Exception('Failed to send email: $e');
    }
  }

  Future<void> _sendViaSES(Message message) async {
    if (_sesClient == null) {
      throw Exception('SES client not initialized');
    }

    final payload = {
      'Action': 'SendEmail',
      'Source': message.from.toString(),
      'Destination.ToAddresses.member.1': message.recipients.first,
      'Message.Subject.Data': message.subject,
      'Message.Body.Text.Data': message.text ?? '',
    };

    if (message.html != null) {
      payload['Message.Body.Html.Data'] = message.html!;
    }

    // Add CC recipients
    for (var i = 0; i < message.ccRecipients.length; i++) {
      payload['Destination.CcAddresses.member.${i + 1}'] = message.ccRecipients[i];
    }

    // Add BCC recipients
    for (var i = 0; i < message.bccRecipients.length; i++) {
      payload['Destination.BccAddresses.member.${i + 1}'] = message.bccRecipients[i];
    }

    try {
      final response = await _sesClient!.request(
        method: 'POST',
        path: '/',
        queryParameters: payload,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send email via SES: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send email via SES: $e');
    }
  }

  Future<void> configureEmailService({
    required String provider,
    required Map<String, String> credentials,
  }) async {
    await _storage.deleteAll();

    await _storage.write(key: 'email_provider', value: provider);

    for (final entry in credentials.entries) {
      await _storage.write(key: entry.key, value: entry.value);
    }

    await initialize();
  }

  Future<void> sendVerificationEmail(String email, String verificationToken) async {
    final verificationLink = await _storage.read(key: 'verification_base_url') ?? 
        'https://ribaru.app/verify';
    
    final fullLink = '$verificationLink?token=$verificationToken';
    
    await sendEmail(
      to: email,
      subject: 'Verify Your Ribaru Account',
      body: '''
Dear Ribaru User,

Thank you for registering with Ribaru! Please verify your email address by clicking the link below:

$fullLink

This link will expire in 24 hours.

If you did not create a Ribaru account, please ignore this email.

Best regards,
The Ribaru Team
''',
    );
  }

  Future<void> sendPasswordResetEmail(String email, String resetToken) async {
    final resetLink = await _storage.read(key: 'reset_password_base_url') ?? 
        'https://ribaru.app/reset-password';
    
    final fullLink = '$resetLink?token=$resetToken';
    
    await sendEmail(
      to: email,
      subject: 'Reset Your Ribaru Password',
      body: '''
Dear Ribaru User,

We received a request to reset your password. Click the link below to create a new password:

$fullLink

This link will expire in 1 hour.

If you did not request a password reset, please ignore this email.

Best regards,
The Ribaru Team
''',
    );
  }

  Future<void> sendWelcomeEmail(String email, String name) async {
    await sendEmail(
      to: email,
      subject: 'Welcome to Ribaru!',
      body: '''
Dear $name,

Welcome to Ribaru! We're excited to have you on board.

Ribaru is your all-in-one business management solution designed specifically for African businesses. Here are some things you can do with Ribaru:

1. Manage your inventory efficiently
2. Process sales and track revenue
3. Generate detailed business reports
4. Manage your team and their roles

If you need any help getting started, our support team is always here to assist you.

Best regards,
The Ribaru Team
''',
    );
  }
}
