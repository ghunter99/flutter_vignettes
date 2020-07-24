import 'package:flutter/material.dart';

class StopwatchContent extends StatefulWidget {
  @override
  _StopwatchContentState createState() => _StopwatchContentState();
}

class _StopwatchContentState extends State<StopwatchContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF75B7E1),
      extendBody: true,
      body: Container(
        child: const Icon(Icons.watch_later),
      ),
    );
  }
}
