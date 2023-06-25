import 'package:flutter/material.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/pages/orders/widgets/historytab.dart';
import 'package:ila/app/view/pages/orders/widgets/ongoingtab.dart';

import '../../shared/widgets/customtext.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeightBox20,
              const Padding(
                padding: EdgeInsets.all(15),
                child: CustomText(
                  text: "My Orders",
                  size: 24,
                ),
              ),
              kHeightBox10,
              const TabBar(indicatorSize: TabBarIndicatorSize.tab, tabs: [
                Tab(
                  text: "Ongoing",
                ),
                Tab(
                  text: "History",
                ),
              ]),
              Expanded(
                  child:
                      TabBarView(children: [const OngoingTab(), HistoryTab()]))
            ],
          ),
        ),
      ),
    );
  }
}
