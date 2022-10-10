import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'enter_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter("sudoku");
  await Hive.openBox("ayarlar");
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box("ayarlar").listenable(keys: ["dil"]),
        builder: (context, box, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.dark(),
            home: const EnterPage(),
          );
        });
  }
}
