import 'package:get/get.dart';
import 'package:ila/app/services/payment_services.dart';
import 'package:ila/app/utils/api/razorpay_key.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  Razorpay _razorpay = Razorpay();
  PaymentServices paymentServices = PaymentServices();
  RazorPayKey razorPayKey = RazorPayKey();

  @override
  void onInit() {
    _razorpay = Razorpay();
    _razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, paymentServices.handlePaymentSuccess);
    _razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, paymentServices.handlePaymentError);
    _razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, paymentServices.handleExternalWallet);
    super.onInit();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void initiatePayment() {
    var options = {
      'key': razorPayKey.razorKey,
      'amount': 10000, // Payment amount in paise (e.g., 10000 paise = ₹100)
      'name': 'ILA trial',
      'description': 'Test Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm'] // Supported wallets for external payments
      }
    };

    _razorpay.open(options);
  }
}
