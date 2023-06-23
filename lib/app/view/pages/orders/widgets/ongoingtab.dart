import 'package:flutter/material.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

class OngoingTab extends StatelessWidget {
  const OngoingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: ShapeDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          "https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                                kWidthBox15,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(text: "Arabian Hut",size: 16,weight: FontWeight.bold,),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                         CustomText(
                                          text:'₹580',
                                          
                                          color: kBlueShade,
                                            size: 15,
                                            weight: FontWeight.w700,
                                          
                                        ),
                                        kWidthBox15,
                                        CustomText(text: "|",size: 22,color: kGrey,),
                                       kWidthBox15,
                                         CustomText(
                                           text:'03 Items',
                                           
                                             color: kGreyDark,
                                             size: 15,
                                             weight: FontWeight.w400,
                                           
                                         ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                                const CustomText(text: "#1245432",align: TextAlign.right,)
    
                          ],
                        ),
                        kHeightBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                width: 150,height: 45,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: kGreen,
                        
                        elevation: 0),
                    child: Text(
                      "Track Order",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                width: 150,height: 45,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: kOrange),
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: kWhite,
                       
                        elevation: 0),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: kOrange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context,index)=>const Divider(),),
                    const Divider(),
                    kHeightBox10,
                    Center(child: CustomText(text: "No More Orders",size: 15,color: kGrey,),)
          ],
        ),
      ),
    );
  }
}
