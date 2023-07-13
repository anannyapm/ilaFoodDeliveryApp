import 'dart:developer';

import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/pages/cart/widgets/successpage.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentServices {
  handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Payment successful
    String? paymentId = response.paymentId;
    await cartController.addToOrders(paymentId);
    cartController.clearCartData();
    Get.off(() => const SuccessPage());
    log("Payment Successful - ID: $paymentId");
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Payment failed
    String? errorMessage = response.message;
    log(response.error.toString());
    
    showSnackBar("Payment Failed", "$errorMessage", kWarning);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Payment made via external wallet (e.g., Paytm)
    String? walletName = response.walletName;
    showSnackBar("External Wallet Selected", "$walletName", kOrange);
  }
}
