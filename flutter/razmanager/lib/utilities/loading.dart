import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: Tween<double>(begin: 0, end: -1)
          .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic)),
      child: const SizedBox(
          height: 200, width: 200, child: Align(alignment: Alignment.bottomCenter, child: Icon(Icons.toys, size: 40))),
    );
  }
}
