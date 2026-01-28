import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../app_drawer.dart';
import '../app_model.dart';
import '../app_progress_indicator.dart';
import 'exception_message.dart';
import 'intent.dart';
import 'loading.dart';

abstract class ViewMasterDetailBase extends StatefulWidget {
  const ViewMasterDetailBase({super.key, required this.id});
  final String? id;
}

abstract class ViewMasterDetailStateBase<TReadProto> extends State<ViewMasterDetailBase> with ExceptionMessage {
  ViewMasterDetailStateBase({required this.header, required this.child, this.bottomNavigationBar, this.shouldPop = true});
  final String header;
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool shouldPop;
  late TReadProto readProto;

  StreamSubscription<String>? exceptionStreamSubscription;

  Future<TReadProto> read(String id);

  @override
  didChangeDependencies() {
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

  Future<void> futureRead() async {
    final model = context.read<AppModel>();
    model.setBusy(value: true, notify: false);
    try {
      readProto = await read(widget.id!);
    } finally {
      model.setBusy(value: false, notify: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: futureRead(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              return Actions(actions: {
                if (this.shouldPop)
                  CloseIntent: CallbackAction<CloseIntent>(onInvoke: (intent) {
                    context.pop();
                    return;
                  }),
              }, child: Focus(autofocus: true, child: child));
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(header),
                  flexibleSpace: const AppProgressIndicator(),
                ),
                body: Actions(
                  actions: {
                    if (this.shouldPop)
                      CloseIntent: CallbackAction<CloseIntent>(onInvoke: (intent) {
                        context.pop();
                        return;
                      }),
                  },
                  child: Focus(
                    autofocus: true,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text(exceptionMessage(snapshot.error))),
                    ),
                  ),
                ),
                bottomNavigationBar: bottomNavigationBar,
                drawer: shouldPop ? null : const AppDrawer(),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(header),
                flexibleSpace: const AppProgressIndicator(),
              ),
              body: const Center(child: Loading()),
              drawer: shouldPop ? null : const AppDrawer(),
            );
          }
        });
  }
}
