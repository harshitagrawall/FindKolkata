import 'package:flutter/material.dart';

class TandC extends StatefulWidget {
  const TandC({super.key});

  @override
  State<TandC> createState() => _TandCState();
}

class _TandCState extends State<TandC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Terms And Conditions'),
      ),
      body: Center(child: Text('Terms and Conditions')),
    );
  }
}
