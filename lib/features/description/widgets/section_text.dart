import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/styles.dart';

class SectionText extends StatelessWidget {
  final String data;
  final String title;
  const SectionText({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Styles.textStyle20,),
        const SizedBox(height: 10,),
        data == ""
            ? const Text("No Description", style: Styles.textStyle16,)
            : Text(data, style: Styles.textStyle16,)
      ],
    );
  }

}