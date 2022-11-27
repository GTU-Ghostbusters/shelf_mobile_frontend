import 'package:flutter/material.dart';

class ShareBookPage extends StatefulWidget {
  const ShareBookPage({super.key});

  @override
  State<ShareBookPage> createState() => _ShareBookPageState();
}

class _ShareBookPageState extends State<ShareBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: [
              Color.fromARGB(70, 255, 131, 220),
              Color.fromARGB(70, 246, 238, 243),
              Color.fromARGB(70, 76, 185, 252),
            ],
          ),
        ),
      ),
    );
  }
}