import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/assets.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: whiteColor,
            ),
            child: Image.asset(Assets.logo, width: 35, fit: BoxFit.fill,)
          ),

          const SizedBox(width: 20,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily",
                  style: Styles.textStyle26.copyWith(color: whiteColor),
                ),
            
                Text(
                  "Today: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  style: Styles.textStyle14.copyWith(color: whiteColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}