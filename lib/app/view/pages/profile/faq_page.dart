import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/shared/widgets/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/constants.dart';
import '../../shared/widgets/close_widget.dart';
import '../../shared/widgets/custom_text.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              kHeightBox10,
              Row(
                children: [
                  CloseWidget(actionfunction: () => Get.back()),
                  kWidthBox15,
                  const CustomText(
                    text: "FAQs",
                    size: 20,
                  )
                ],
              ),
              kHeightBox20,
              const FAQItem(
                question: 'How do I place an order?',
                answer:
                    'To place an order, open the app and browse through the available restaurants. Select the items you want to order and proceed to checkout. Provide your delivery address and payment details to complete the order.',
              ),
              const FAQItem(
                question: 'How long does delivery take?',
                answer:
                    'Delivery times may vary depending on the restaurant and your location. Typically, deliveries are made within 30-45 minutes from the time the order is placed.',
              ),
              const FAQItem(
                question: 'Can I track my order?',
                answer:
                    'Yes, you can track your order in real-time. Once your order is confirmed, you can visit my orders page and click on the track order to see the status and delivery details.',
              ),
              const FAQItem(
                question: 'What payment methods are accepted?',
                answer:
                    'We accept various payment methods, including credit/debit cards, mobile wallets, and upi. Choose your preferred payment option during the checkout process.',
              ),
              const FAQItem(
                question: 'Is there a minimum order amount?',
                answer:
                    'Some restaurants may have a minimum order requirement. You will be notified during the ordering process if a minimum order amount applies.',
              ),
              kHeightBox60,
              Column(
                children: [
                  const CustomText(
                    text: "Want help with something else?",
                    size: 18,
                  ),
                  const CustomText(
                    text: "Get in touch with Us",
                    size: 18,
                  ),
                  TextButton(
                      onPressed: () async {
                        String email =
                            Uri.encodeComponent("ilafooddelivery@gmail.com");
                        String subject = Uri.encodeComponent(
                            "Query About Ila Food Delivery App");
                        String body = Uri.encodeComponent("Hi There!");
                        debugPrint("Mail Subject:$subject");
                        Uri mail = Uri.parse(
                            "mailto:$email?subject=$subject&body=$body");
                        if (await launchUrl(mail)) {
                          //email app opened
                        } else {
                          showSnackBar(
                              "Oops",
                              "Something went wrong,Please try again later",
                              kWarning);
                        }
                      },
                      child: const CustomText(
                        text: "ilafooddelivery@gmail.com",
                        size: 18,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  FAQItemState createState() => FAQItemState();
}

class FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Get.isDarkMode ? kGrey.withOpacity(0.5) : kOffBlue,
        collapsedBackgroundColor:
            Get.isDarkMode ? kGrey.withOpacity(0.4) : kOffBlue,
        title: CustomText(
          text: widget.question,
          weight: FontWeight.bold,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        initiallyExpanded: _isExpanded,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: CustomText(text: widget.answer),
          ),
        ],
      ),
    );
  }
}
