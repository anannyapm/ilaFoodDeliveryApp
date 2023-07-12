import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/model/notification_model.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

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
                child: Obx(() => notificationController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :notificationController.notifications.isEmpty? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Ionicons.notifications_outline,size: 80,color:Get.isDarkMode?kWhite:kGreyDark,),
                          kHeightBox20,
                          CustomText(text: "No Notifications here",size: 18,weight: FontWeight.w200,color: Get.isDarkMode?kWhite:kGreyDark,)
                        ],
                      )
                    ): Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListView.separated(
                          itemCount:
                              notificationController.notifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel item =
                                notificationController.notifications[index];
                            DateTime today = DateTime.now();
                            bool istoday =
                                (item.startTime!.month == today.month &&
                                        item.startTime!.year == today.year &&
                                        item.startTime!.day == today.day)
                                    ? true
                                    : false;
                            return ListTile(
                              contentPadding: const EdgeInsets.only(top: 5),
                              leading: CircleAvatar(
                                backgroundColor: kOffBlue,
                                radius: 25,
                                child: Icon(Icons.notifications,
                                    color: index == 0 ? kGreen : kBlueShade),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: item.title!,
                                    color:Get.isDarkMode?kWhite: kGreyDark,
                                    size: 16,
                                    weight: FontWeight.bold,
                                  ),
                                  CustomText(
                                    text: istoday
                                        ? "Today"
                                        : DateFormat("dd/mm/yy")
                                            .format(item.startTime!),
                                    color:Get.isDarkMode?kGrey: kBlueShade.withOpacity(0.7),
                                    size: 13,
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width*0.55,
                                    child: CustomText(
                                      text: item.body!,
                                      lines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      color:Get.isDarkMode?kWhite: kGreyDark,
                                      size: 15,
                                    ),
                                  ),
                                  CustomText(
                                    text: DateFormat("h:mm a")
                                        .format(item.startTime!),
                                    color:Get.isDarkMode?kGrey: kBlueShade.withOpacity(0.7),
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
