import 'dart:developer';

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

  void initiatePayment({required int amount,required String name,required phoneNumber,String email="test@razorpay.com"}) {
    var options = {
      'key': razorPayKey.razorKey,
      'amount': amount, // Payment amount in paise (e.g., 10000 paise = ₹100)
      'name': name,
      'description': 'Test Payment for ILA App',
      'prefill': {'contact': phoneNumber,'email': email},
      'external': {
        'wallets': ['paytm'] // Supported wallets for external payments
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }
}
