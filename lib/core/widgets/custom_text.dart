import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';

class CustomText extends StatelessWidget {
  final String title;
  final int minLines;
  final int maxLines;
  final TextEditingController textController;
  final String? Function(String?)? validator;

  const CustomText({
    super.key,
    required this.textController,
    required this.minLines,
    required this.maxLines,
    required this.title,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            title,
            style: Styles.textStyle16,
            textAlign: TextAlign.start,
          ),
        ),

        const SizedBox(height: 5,),

        TextFormField(
          controller: textController,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            hintText: "Add $title of Task",
            filled: true,
            fillColor: bageColor,
            errorStyle: Styles.textStyle14.copyWith(color: mainColor),
            prefixIcon: const Icon(Icons.add),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: mainColor,
                )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                  color: mainColor
              ),
            )
          ),
        ),

        const SizedBox(height: 15,),
      ],
    );
  }

}