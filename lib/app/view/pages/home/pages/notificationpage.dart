import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/constants.dart';
import '../../../shared/widgets/customtext.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis',
    'Ut enim ad minim veniam, quis nostrud exercitation', 
  ];
  final List<String> dummyImages = [
    'https://images.pexels.com/photos/2983099/pexels-photo-2983099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/1343464/pexels-photo-1343464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://img.freepik.com/premium-vector/warning-icon-red-vector-graphics_292645-287.jpg?w=2000', 
  ];

  NotificationPage({super.key});

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
                child: ListView.separated(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    
                    return ListTile(
                      contentPadding: const EdgeInsets.only(top: 5),
                      leading:CircleAvatar(radius: 35,backgroundImage: NetworkImage(dummyImages[index]),) ,
                      title:CustomText(text: notifications[index],color: kGreyDark,size: 15,) ,
                      subtitle: CustomText(text:"Today,${DateFormat("h:mm a").format(DateTime.now())}",color: kGrey,size: 13,),
                      
                     
                    );
                  },
                  separatorBuilder: (context, index) => Divider(color: kGrey.withOpacity(0.4),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
