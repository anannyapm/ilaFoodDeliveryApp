import 'package:flutter/material.dart';
import 'package:ila/app/utils/constants/color_constants.dart';
import 'package:ila/app/utils/constants/constants.dart';
import 'package:ila/app/view/shared/widgets/custom_text.dart';

class TrackWidget extends StatelessWidget {
  final int currentStage;

  const TrackWidget({super.key, required this.currentStage});

  @override
  Widget build(BuildContext context) {
    return Column(
     
      children: [
        _buildStageContainer(1, 'Stage 1'),
        _buildStageContainer(2, 'Stage 2'),
        _buildStageContainer(3, 'Stage 3'),
        _buildStageContainer(4, 'Stage 4'),
      ],
    );
  }

  Widget _buildStageContainer(int stage, String stageName) {
    Color color;
    IconData icon;
    String text;
    if (stage == currentStage) {
      color = kOrange;
      icon = Icons.timelapse_outlined;
      
    } else if (stage < currentStage) {
      color = kGreen;
      icon = Icons.done;
    
    } else {
      color = kGrey;
      icon = Icons.done;
    }

    if(stage==1){
      text = "Your order has been received";
    }
    else if(stage==2){
      text = "The restaurant is preparing your food";

    }
    else if(stage==3){
      text = "Your order is out for delivery";

    }
    else{
      text = "Order arriving soon!";

    }

    return Column(
      
      children: [
        Row(
          
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: color,
              child: Icon(
                icon,
                size: 12,
                color: kWhite,
              ),
            ),
            kWidthBox15,
            CustomText(text: text,size: 14,color: color,weight: FontWeight.w500,)
          ],
        ),
        stage==4?Container():Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 1,
              height: 40,
              decoration: BoxDecoration(color: color),
            ),
          ),
        )
      ],
    );
   
  }
}
