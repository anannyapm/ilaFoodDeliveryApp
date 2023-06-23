import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/customtext.dart';

class HeaderCard extends StatelessWidget {
  final String imageUrl;

  final num? rate;
  final bool isFav;

  const HeaderCard({
    super.key,
    required this.imageUrl,
    required this.rate,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        surfaceTintColor: kWhite,
        color: kWhite,
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: kBlack.withOpacity(0.2)),
              ),
              Positioned(
                right:16,
                bottom: 16,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(kWhite)),
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: isFav == true ? kGreen : kGreyDark,
                      )),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(kWhite)),
                      onPressed: () =>Get.back(),
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                      )),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children:[IconButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(kWhite)),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_bag_outlined
                        )),
                        Positioned(
                          bottom: 2,
                          right: 0.5,
                          child: CircleAvatar(radius:12,backgroundColor: kOrange,child: CustomText(text: "2",size: 12,color: kWhite,),))],
                  ),
                ),
              ),
              rate==null?Container():Positioned(
                bottom:16,
                left: 16,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 30,
                      width: 65,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: kOrange,
                            ),
                            kWidthBox10,
                            CustomText(
                              text: rate.toString(),
                              weight: FontWeight.bold,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    )),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
