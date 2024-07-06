import 'package:flutter/material.dart';
import 'package:to_do_list/features/add_task/add_task.dart';
import 'package:to_do_list/features/home/home.dart';
import 'package:to_do_list/core/utils/constant.dart';

void main() {
  runApp(const ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: whiteColor,
        fontFamily: "RobotoSlab",
        colorScheme: const ColorScheme.light().copyWith(
          primary: mainColor
        ),
        appBarTheme: const AppBarTheme(
          color: mainColor,
          toolbarHeight: 80,
          iconTheme: IconThemeData(
            color: whiteColor,
            size: 24
          ),
          titleTextStyle: TextStyle(
            color: whiteColor,
            fontFamily: "RobotoSlab"
          )
        )
      ),
      routes: {
        "addTask": (context) => const AddTask(),
        "home": (context) => const Home()
      },
    );
  }

}