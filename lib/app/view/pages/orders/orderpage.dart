import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/orders/widgets/historytab.dart';
import 'package:ila/app/view/pages/orders/widgets/ongoingtab.dart';

import '../../../utils/constants/color_constants.dart';
import '../../shared/widgets/customtext.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Container(
           
            child:Column(

              children: [
                kHeightBox10,
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    kGreylight.withOpacity(0.4))),
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 30,
                            ),
                          ),
                          kWidthBox15,
                          const CustomText(
                            text: "My Orders",
                            size: 20,
                          ),
                          kHeightBox20,
                          
                        ],
                      ),
                ),
                kHeightBox20,
                const TabBar(
            
                  indicatorSize:TabBarIndicatorSize.tab,
                  tabs: [
                              Tab(text: "Ongoing",),
                              Tab(text: "History",),
                            ]),
                 Expanded(
                  child: TabBarView(
                    children: [
                    OngoingTab(),
                    HistoryTab()
                  ])
                )
              ],
            )
             
          ),
        ),
      ),
    );
  }
}