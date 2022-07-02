import 'package:flutter/material.dart';

class PathScreen extends StatefulWidget {
  const PathScreen({this.listOfPlaces, Key? key}) : super(key: key);
  static const String id = 'path_screen';
  final List? listOfPlaces;

  @override
  State<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  List places = [];

  @override
  initState() {
    super.initState();
    places = widget.listOfPlaces!;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
