import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ribaru_v2/core/theme/app_theme.dart';
import 'package:ribaru_v2/core/widgets/app_button.dart';
import 'package:ribaru_v2/features/auth/services/auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String? token;
  
  const VerifyEmailScreen({
    super.key,
    this.token,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isVerified = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      _verifyToken(widget.token!);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _verifyToken(String token) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await AuthService().verifyEmail(token);
      setState(() {
        _isVerified = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _resendVerification() async {
    if (_emailController.text.isEmpty) {
      setState(() => _error = 'Please enter your email');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await AuthService().resendVerification(_emailController.text);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification email sent')),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isVerified) ...[
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Email Verified!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your email has been successfully verified.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                AppButton(
                  onPressed: () => context.go('/dashboard'),
                  child: const Text('Continue to Dashboard'),
                ),
              ] else if (widget.token != null) ...[
                if (_isLoading)
                  const CircularProgressIndicator()
                else ...[
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Verification Failed',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error ?? 'An error occurred during verification.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.error),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Back to Login'),
                  ),
                ],
              ] else ...[
                const Icon(
                  Icons.mail_outline,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Verify Your Email',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter your email to resend the verification link.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !_isLoading,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: const TextStyle(color: AppColors.error),
                  ),
                ],
                const SizedBox(height: 24),
                AppButton(
                  onPressed: _isLoading ? null : _resendVerification,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Resend Verification Email'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Back to Login'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
