import 'package:flutter/material.dart';
import 'package:list_detail_extension/AppExtension.dart';
import 'package:list_detail_extension/pustaka_detail_screen.dart'
    deferred as detail_screen;

class ListDetailExtension implements AppExtension {
  @override
  String get id => "list_detail";

  @override
  String get name => "List Detail Viewer";

  @override
  Future<void> load() async {
    await detail_screen.loadLibrary();
  }

  @override
  Widget buildPage(Map<String, dynamic> args) {
    return detail_screen.ListDetailScreen(
      title: args['title'],
      imagePath: args['imagePath'],
      paragraphs: args['paragraphs'],
      filepath: args['filepath'],
    );
  }
}
