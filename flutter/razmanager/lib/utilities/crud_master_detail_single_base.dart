import 'package:flutter/material.dart';

import '../app_progress_indicator.dart';
import 'crud_master_detail_base.dart';

abstract class CrudMasterDetailSingleStateBase<TReadProto> extends CrudMasterDetailStateBase<TReadProto> {
  CrudMasterDetailSingleStateBase({required String header, required Widget child})
      : super(header: header, child: _CrudMasterDetailSingleChild(header: header, child: child));
}

class _CrudMasterDetailSingleChild extends StatelessWidget {
  const _CrudMasterDetailSingleChild({required this.header, required this.child});

  final String header;
  final Widget child;

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
      bottomNavigationBar: const ReactiveFormBottomAppBar(),
    );
  }
}
