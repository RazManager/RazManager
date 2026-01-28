import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_drawer.dart';
import '../app_progress_indicator.dart';
import '../refresh_model.dart';
import 'exception_message.dart';
import 'loading.dart';

abstract class FutureBuilderScaffoldStateBase<TStatefulWidget extends StatefulWidget> extends State<TStatefulWidget> with ExceptionMessage {
  FutureBuilderScaffoldStateBase(
      {required this.header, required this.useRefresh, required this.useAppDrawer, required this.body, this.bottomNavigationBar});
  final String header;
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool useRefresh;
  final bool useAppDrawer;

  Future<void> initializeData();
  Future<void> refreshData({required bool notify});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: initializeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              final title = header;
              return Scaffold(
                appBar: AppBar(
                  title: Text(title),
                  flexibleSpace: const AppProgressIndicator(),
                  actions: useRefresh
                      ? [
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            tooltip: 'F5 - Refresh',
                            onPressed: () async {
                              final refreshModel = context.read<RefreshModel>();
                              await refreshData(notify: true);
                              refreshModel.refreshed();
                            },
                          ),
                        ]
                      : null,
                ),
                body: body,
                bottomNavigationBar: bottomNavigationBar,
              drawer: useAppDrawer ? const AppDrawer() : null,
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(header),
                  flexibleSpace: const AppProgressIndicator(),
                ),
                body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text(exceptionMessage(snapshot.error))),
                    ),
              drawer: useAppDrawer ? const AppDrawer() : null,
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(header),
                flexibleSpace: const AppProgressIndicator(),
              ),
              body: const Center(child: Loading()),
              drawer: useAppDrawer ? const AppDrawer() : null,
            );
          }
        });
  }
}
