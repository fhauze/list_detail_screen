import 'package:flutter/material.dart';

abstract class AppExtension {
  String get id;
  String get name;
  Future<void> load();
  Widget buildPage(Map<String, dynamic> args);
}
