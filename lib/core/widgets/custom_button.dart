import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;

  const CustomButton({super.key, this.onPressed, required this.name,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: MaterialButton(
        onPressed: onPressed,
        color: mainColor,
        textColor: bageColor,
        padding: const EdgeInsets.all(10),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none
        ),
        child: Text(
          name,
          style: Styles.textStyle16,
        ),
      ),
    );
  }

}