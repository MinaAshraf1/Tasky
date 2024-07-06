import 'package:flutter/material.dart';
import 'package:to_do_list/core/utils/constant.dart';
import 'package:to_do_list/core/utils/styles.dart';

class ImportantItem extends StatelessWidget {
  final String title;
  final String description;final void Function()? onTap;

  const ImportantItem({
    super.key,
    required this.title,
    required this.description,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: darkGreyColor,
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: Styles.textStyle20.copyWith(color: whiteColor),
        ),
        subtitle: Text(
          description,
          style: Styles.textStyle14.copyWith(color: bageColor, fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }

}