import 'package:flutter/material.dart';

void main() {
  runApp(const StartLinkBusiness());
}

class StartLinkBusiness extends StatelessWidget {
  const StartLinkBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartLink Business',
      home: Scaffold(
        appBar: AppBar(title: const Text('StartLink')),
        body: const Center(
          child: Text('مرحبا بك في StartLink - تطبيق المؤسسات الناشئة'),
        ),
      ),
    );
  }
}
