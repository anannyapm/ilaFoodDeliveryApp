import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/notification_model.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/custom_text.dart';

class NotificationPage extends StatelessWidget {


  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              kHeightBox10,
              Row(
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
                    text: "Notifications",
                    size: 20,
                  )
                ],
              ),
              kHeightBox20,
              Expanded(
                child: Obx(() => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ListView.separated(
                        itemCount: notificationController
                            .notifications.length, 
                        itemBuilder: (context, index) {
                          NotificationModel item =
                              notificationController.notifications[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.only(top: 5),
                            leading:  CircleAvatar(
                              backgroundColor:kOffBlue,
                              radius: 25,
                              child: Icon(Icons.notifications,color:index==notificationController.notifications.length-1?kBlueShade:kGreen ),
                              
                            ),
                            title: CustomText(
                              text: item.title!,
                              color: kGreyDark,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: item.body!,
                                  lines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  color: kGreyDark,
                                  size: 15,
                                ),
                                CustomText(
                                  text: DateFormat("h:mm a")
                                      .format(item.startTime!),
                                  color: kBlueShade.withOpacity(0.7),
                                  size: 13,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: kGrey.withOpacity(0.4),
                        ),
                      ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
