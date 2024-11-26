import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class MpesaService {
  static final MpesaService _instance = MpesaService._internal();
  factory MpesaService() => _instance;
  MpesaService._internal();

  static const String _consumerKey = 'YOUR_CONSUMER_KEY';
  static const String _consumerSecret = 'YOUR_CONSUMER_SECRET';
  static const String _businessShortCode = 'YOUR_BUSINESS_SHORTCODE';
  static const String _passKey = 'YOUR_PASS_KEY';

  Future<void> initialize() async {
    MpesaFlutterPlugin.setConsumerKey(_consumerKey);
    MpesaFlutterPlugin.setConsumerSecret(_consumerSecret);
  }

  Future<Map<String, dynamic>> startStkPush({
    required String phoneNumber,
    required double amount,
    required String reference,
  }) async {
    try {
      final transactionResult = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: _businessShortCode,
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: phoneNumber,
        partyB: _businessShortCode,
        phoneNumber: phoneNumber,
        callBackURL: 'YOUR_CALLBACK_URL',
        accountReference: reference,
        transactionDesc: 'Payment for order $reference',
        passKey: _passKey,
      );

      return {
        'success': true,
        'transactionId': transactionResult['CheckoutRequestID'],
        'message': 'STK push initiated successfully',
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> checkTransactionStatus(String transactionId) async {
    try {
      final result = await MpesaFlutterPlugin.queryTransactionStatus(
        businessShortCode: _businessShortCode,
        checkoutRequestID: transactionId,
        passKey: _passKey,
      );

      return {
        'success': true,
        'status': result['ResultDesc'],
        'data': result,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
