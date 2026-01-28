import 'package:flutter/material.dart';

import '../app_progress_indicator.dart';
import 'view_master_detail_base.dart';

abstract class ViewMasterDetailSingleStateBase<TReadProto> extends ViewMasterDetailStateBase<TReadProto> {
  ViewMasterDetailSingleStateBase({required super.header, required Widget child, Widget? bottomNavigationBar})
      : super(
            child:
                _ViewMasterDetailSingleChild(header: header, bottomNavigationBar: bottomNavigationBar, child: child));
}

class _ViewMasterDetailSingleChild extends StatelessWidget {
  const _ViewMasterDetailSingleChild({required this.header, required this.child, this.bottomNavigationBar});

  final String header;
  final Widget child;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(header),
          flexibleSpace: const AppProgressIndicator(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar);
  }
}
