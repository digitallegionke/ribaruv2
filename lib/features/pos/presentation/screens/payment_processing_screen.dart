import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ribaru_v2/features/pos/domain/models/order.dart';
import 'package:ribaru_v2/features/pos/domain/models/payment.dart';
import 'package:ribaru_v2/features/pos/presentation/providers/payment_provider.dart';
import 'package:ribaru_v2/features/pos/presentation/widgets/split_payment_sheet.dart';
import 'package:ribaru_v2/features/pos/services/mpesa_service.dart';

class PaymentProcessingScreen extends StatefulWidget {
  final Order order;
  final String staffId;

  const PaymentProcessingScreen({
    super.key,
    required this.order,
    required this.staffId,
  });

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  final MpesaService _mpesaService = MpesaService();
  final TextEditingController _phoneController = TextEditingController();
  bool _isProcessingMpesa = false;
  String? _mpesaError;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _processMpesaPayment() async {
    if (_phoneController.text.isEmpty) {
      setState(() => _mpesaError = 'Please enter a phone number');
      return;
    }

    setState(() {
      _isProcessingMpesa = true;
      _mpesaError = null;
    });

    try {
      final result = await _mpesaService.startStkPush(
        phoneNumber: _phoneController.text,
        amount: widget.order.total,
        reference: widget.order.id,
      );

      if (result['success']) {
        // Process payment with transaction ID
        final success = await context.read<PaymentProvider>().processPayment(
              widget.order,
              widget.staffId,
            );

        if (success) {
          if (mounted) {
            Navigator.pop(context, true);
          }
        } else {
          setState(() => _mpesaError = 'Payment processing failed');
        }
      } else {
        setState(() => _mpesaError = result['message']);
      }
    } catch (e) {
      setState(() => _mpesaError = e.toString());
    } finally {
      setState(() => _isProcessingMpesa = false);
    }
  }

  Future<void> _processCashPayment() async {
    final success = await context.read<PaymentProvider>().processPayment(
          widget.order,
          widget.staffId,
        );

    if (success) {
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  void _showSplitPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SplitPaymentSheet(
        order: widget.order,
        onConfirm: (splitPayments) async {
          Navigator.pop(context);
          final success = await context.read<PaymentProvider>().processPayment(
                widget.order,
                widget.staffId,
                splitPayments: splitPayments,
              );

          if (success && mounted) {
            Navigator.pop(context, true);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Process Payment'),
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, provider, child) {
          if (provider.isProcessing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Order summary card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Order ID: ${widget.order.id}'),
                        Text(
                          'Total: KES ${widget.order.total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Payment method selection
                Text(
                  'Select Payment Method',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),

                // M-PESA payment section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'M-PESA',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '254XXXXXXXXX',
                            errorText: _mpesaError,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _isProcessingMpesa
                              ? null
                              : () => _processMpesaPayment(),
                          child: _isProcessingMpesa
                              ? const CircularProgressIndicator()
                              : const Text('Pay with M-PESA'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Cash payment section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Cash',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _processCashPayment(),
                          child: const Text('Pay with Cash'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Split payment section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Split Payment',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _showSplitPaymentSheet(),
                          child: const Text('Split Payment'),
                        ),
                      ],
                    ),
                  ),
                ),

                if (provider.error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    provider.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
