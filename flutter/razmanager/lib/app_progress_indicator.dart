import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_model.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, model, child) {
      if (model.busy) {
        return const LinearProgressIndicator(value: null);
      } else {
        return const SizedBox(height: 4);
      }
    });
  }
}
