import 'package:flutter/material.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                 height: MediaQuery.of(context).size.height*0.6,
                 
                 decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/success.png"))),
                ),
                const CustomText(text: "Order Placed !",size: 25,weight: FontWeight.bold,),
                CustomText(text: "Keep Your Plates Ready!\nYour order shall be delivered soon.",size: 18,color: kGreyDark,align:TextAlign.center,),
               
              ],
            ),
             SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: kGreen,
                        padding: const EdgeInsets.all(15),
                        elevation: 0),
                    child: Text(
                      "DONE",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              kHeightBox10
          ],
        ),
      )),
    );
  }
}