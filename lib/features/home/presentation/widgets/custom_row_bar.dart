import 'package:flutter/material.dart';
import 'package:food_hub/core/utils/app_styles.dart';

class CustomRowBar extends StatelessWidget {
  String textOne;
  String textTwo;
  void Function()? onTap;
  CustomRowBar({super.key,required this.textOne,required this.textTwo,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textOne,style: AppFontStyles.w500_18),

        GestureDetector(
          onTap: onTap,
            child: Text(textTwo,style: AppFontStyles.w500_16,)
        )
      ],
    );
  }
}
