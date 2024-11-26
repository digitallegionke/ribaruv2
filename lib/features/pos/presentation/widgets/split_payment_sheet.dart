import 'package:flutter/material.dart';
import 'package:ribaru_v2/features/pos/domain/models/payment.dart';
import 'package:ribaru_v2/features/pos/domain/models/order.dart';

class SplitPaymentSheet extends StatefulWidget {
  final Order order;
  final Function(List<SplitPayment>) onConfirm;

  const SplitPaymentSheet({
    super.key,
    required this.order,
    required this.onConfirm,
  });

  @override
  State<SplitPaymentSheet> createState() => _SplitPaymentSheetState();
}

class _SplitPaymentSheetState extends State<SplitPaymentSheet> {
  final List<SplitPayment> _splitPayments = [];
  double _remainingAmount = 0;

  @override
  void initState() {
    super.initState();
    _remainingAmount = widget.order.total;
  }

  void _addSplitPayment(String method, double amount) {
    if (amount <= 0 || amount > _remainingAmount) return;

    final payment = SplitPayment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      paymentId: '', // Will be set by PaymentService
      paymentMethod: method,
      amount: amount,
      status: PaymentStatus.pending,
      createdAt: DateTime.now(),
    );

    setState(() {
      _splitPayments.add(payment);
      _remainingAmount -= amount;
    });
  }

  void _removeSplitPayment(int index) {
    setState(() {
      _remainingAmount += _splitPayments[index].amount;
      _splitPayments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Split Payment',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          // Remaining amount display
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Remaining Amount:'),
                  Text(
                    'KES ${_remainingAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List of split payments
          if (_splitPayments.isNotEmpty) ...[
            ListView.builder(
              shrinkWrap: true,
              itemCount: _splitPayments.length,
              itemBuilder: (context, index) {
                final payment = _splitPayments[index];
                return ListTile(
                  title: Text(payment.paymentMethod),
                  subtitle: Text('KES ${payment.amount.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeSplitPayment(index),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
          // Add payment method buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PaymentMethodButton(
                icon: Icons.money,
                label: 'Cash',
                onTap: () => _showAmountDialog('cash'),
              ),
              _PaymentMethodButton(
                icon: Icons.phone_android,
                label: 'M-PESA',
                onTap: () => _showAmountDialog('mpesa'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Confirm button
          ElevatedButton(
            onPressed: _remainingAmount == 0
                ? () => widget.onConfirm(_splitPayments)
                : null,
            child: const Text('Confirm Split Payment'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAmountDialog(String method) async {
    final controller = TextEditingController();
    final result = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter ${method.toUpperCase()} Amount'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            prefixText: 'KES ',
            hintText: '0.00',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                Navigator.pop(context, amount);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null) {
      _addSplitPayment(method, result);
    }
  }
}

class _PaymentMethodButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PaymentMethodButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
