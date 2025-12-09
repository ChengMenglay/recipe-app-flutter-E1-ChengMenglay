import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_3/main_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async{
  // Initialize Hive
  await Hive.initFlutter();
  
  //Open a Hive box
  await Hive.openBox('favorites');

  runApp(const ProviderScope(child: MainWidget()));
}
      