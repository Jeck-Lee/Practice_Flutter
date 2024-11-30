import 'package:flutter/material.dart';

class SubWidget extends StatelessWidget {
  const SubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      color: Colors.red,
      child: const Center(
        child: Text(
          '만들어뒀던 일반 위젯',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SubWidget2 extends StatelessWidget {
  const SubWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: Colors.orange,
      child: const Center(
        child: Text(
          '만들어뒀던 일반 위젯2',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}