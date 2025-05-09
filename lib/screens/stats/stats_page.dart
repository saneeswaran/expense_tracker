import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "Stats",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
