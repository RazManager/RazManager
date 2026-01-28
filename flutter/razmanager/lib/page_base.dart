import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';

abstract class PageBase2 extends StatefulWidget {
  const PageBase2({super.key, required this.body});

  final Widget body;

  @override
  State<PageBase2> createState() => _PageBaseState();
}

class _PageBaseState extends State<PageBase2> {
  StreamSubscription<String>? exceptionStreamSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    exceptionStreamSubscription = context.read<AppModel>().exceptionStreamController.stream.listen((message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 10)));
    });
  }

  @override
  void dispose() async {
    super.dispose();
    if (exceptionStreamSubscription != null) {
      await exceptionStreamSubscription!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.width > 2500) {
      return Row(
        children: [Expanded(child: widget.body)],
      );
    } else {
      return widget.body;
    }
  }
}
