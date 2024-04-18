
import 'package:flutter/material.dart';

import '../Resources/CustomSize.dart';

class CustomContainer extends StatelessWidget {
  Color color;
  IconData icon;
  String title;
  String leftTask;
  CustomContainer({super.key,required this.color,required this.title, required this.leftTask,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CustomSize().customWidth(context)/2.4,
      height:CustomSize().customHeight(context)/5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon,color: Colors.white,size: 30),
            Text(title,style: const TextStyle(color: Colors.white,fontSize: 25)),
            Text(leftTask,style: const TextStyle(color: Colors.white,fontSize: 25))
          ],
        ),
      ),
    );
  }
}
