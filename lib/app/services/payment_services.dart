import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/view/pages/cart/widgets/successpage.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentServices {
  handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment successful
    String? paymentId = response.paymentId;
    Get.to(() => const SuccessPage());
    showSnackBar("Payment Successful", "Payment ID: $paymentId", kGreen);

    // Perform further actions after successful payment
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Payment failed
    String? errorMessage = response.message;
    showSnackBar(
        "Payment Failed",
        "Code: ${response.code}\nDescription: $errorMessage\nMetadata:${response.error.toString()}",
        kWarning);
    // Handle payment failure
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Payment made via external wallet (e.g., Paytm)
    String? walletName = response.walletName;
    showSnackBar("External Wallet Selected", "$walletName", kOrange);
    // Handle external wallet payment
  }
}
