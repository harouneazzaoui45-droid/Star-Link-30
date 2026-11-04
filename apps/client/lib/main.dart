import 'package:flutter/material.dart';

void main() {
  runApp(const StartLinkClient());
}

class StartLinkClient extends StatelessWidget {
  const StartLinkClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartLink Client',
      home: Scaffold(
        appBar: AppBar(title: const Text('StartLink')),
        body: const Center(
          child: Text('مرحبا بك في StartLink - تطبيق الزبون'),
        ),
      ),
    );
  }
}
