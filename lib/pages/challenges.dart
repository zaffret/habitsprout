import 'package:flutter/material.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Challenges',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(33, 47, 85, 1))),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: const Center(
          child: Text('Challenges Page', style: TextStyle(fontSize: 24))),
    );
  }
}
