import 'package:flutter/material.dart';

void main() {
  runApp(const StartLinkAdmin());
}

class StartLinkAdmin extends StatelessWidget {
  const StartLinkAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartLink Admin',
      home: Scaffold(
        appBar: AppBar(title: const Text('StartLink')),
        body: const Center(
          child: Text('مرحبا بك في StartLink - تطبيق المدير'),
        ),
      ),
    );
  }
}
