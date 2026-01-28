import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:provider/provider.dart';

import '../app_drawer.dart';
import '../app_model.dart';
import '../app_progress_indicator.dart';
import '../protobuf/razmanager/protobuf/internal/repository/crud_services/common.pb.dart';
import '../refresh_model.dart';
import 'exception_message.dart';
import 'grpc_client.dart';
import 'intent.dart';
import 'loading.dart';

abstract class CrudMasterListStateBase<TListItem, TStatefulWidget extends StatefulWidget> extends State<TStatefulWidget>
    with GrpcClient, ExceptionMessage {
  CrudMasterListStateBase({required this.path, required this.header, required this.body});

  final String path;
  final String header;
  final scrollController = ScrollController(keepScrollOffset: false);
  final Widget body;

  grpc.ClientChannel? clientChannel;
  StreamSubscription<String>? exceptionStreamSubscription;

  late List<TListItem> items = [];
  DateTime itemsRefreshedAt = DateTime.now();
  bool noMoreItems = false;
  bool addItemsBusy = false;

  Future<void> refreshItemsCallback() async {
    setState(() {});
  }

  Future<void> initializeItems() async {
    final model = context.read<AppModel>();
    try {
      model.setBusy(value: true, notify: false);
      clientChannel = createClientChannel();
      await initialize();
      return await refreshItems(notify: false);
    } finally {
      if (clientChannel != null) {
        await clientChannel!.shutdown();
        clientChannel = null;
      }
      model.setBusy(value: false, notify: false);
    }
  }

  Future<void> initialize() async {}

  Future<void> refreshItems({required bool notify}) async {
    final model = context.read<AppModel>();
    try {
      model.setBusy(value: true, notify: notify);

      // if (clientChannel != null) {
      //   await clientChannel!.shutdown();
      // }
      // clientChannel = createClientChannel();

      clientChannel ??= createClientChannel();
      items = await list(ListRequest(limit: 30, offset: 0));
      noMoreItems = false;
      itemsRefreshedAt = DateTime.now();
      //print('refreshItems items.length: ${items.length}');
    } finally {
      if (clientChannel != null) {
        await clientChannel!.shutdown();
        clientChannel = null;
      }
      model.setBusy(value: false, notify: notify);
    }
  }

  Future<void> addItems() async {
    if (!noMoreItems && !addItemsBusy) {
      addItemsBusy = true;
      final model = context.read<AppModel>();
      final refreshModel = context.read<RefreshModel>();
      model.setBusy(value: true, notify: true);
      try {
        clientChannel ??= createClientChannel();
        final result = await list(ListRequest(limit: 5, offset: items.length));
        if (result.isEmpty) {
          noMoreItems = true;
        } else {
          items.addAll(result);
          //print('addItems items.length: ${items.length}');
          refreshModel.refreshed();
        }
      } on Exception catch (exception) {
        model.exceptionStreamController.add(exceptionMessage(exception));
      } finally {
        addItemsBusy = false;
        if (clientChannel != null) {
          await clientChannel!.shutdown();
          clientChannel = null;
        }
        model.setBusy(value: false, notify: true);
      }
    }
  }

  Future list(ListRequest listRequest);

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    scrollController.addListener(() async {
      if (scrollController.position.pixels >= 0.8 * scrollController.position.maxScrollExtent) {
        await addItems();
      }
    });

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
    return FutureBuilder<void>(
        future: initializeItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              return Actions(
                actions: {
                  RefreshIntent: CallbackAction<RefreshIntent>(onInvoke: (intent) async {
                    final model = context.read<AppModel>();
                    try {
                      final refreshModel = context.read<RefreshModel>();
                      await refreshItems(notify: true);
                      refreshModel.refreshed();
                    } on Exception catch (exception) {
                      model.exceptionStreamController.add(exceptionMessage(exception));
                    }
                    return null;
                  })
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(header),
                    flexibleSpace: const AppProgressIndicator(),
                    actions: [
                      Builder(
                        builder: (BuildContext context) => IconButton(
                          icon: const Icon(Icons.refresh),
                          tooltip: 'F5 - Refresh',
                          onPressed: Actions.handler<RefreshIntent>(context, RefreshIntent()),
                        ),
                      )
                    ],
                  ),
                  body: Focus(autofocus: true, child: body),
                  floatingActionButton: FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () {
                        context.push('$path/add', extra: refreshItemsCallback);
                      }),
                  drawer: const AppDrawer(),
                ),
              );
            } else {
              return Actions(
                actions: {RefreshIntent: CallbackAction<RefreshIntent>(onInvoke: (intent) => setState(() {}))},
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(header),
                    flexibleSpace: const AppProgressIndicator(),
                    actions: [
                      Builder(
                        builder: (BuildContext context) => IconButton(
                          icon: const Icon(Icons.refresh),
                          tooltip: 'F5 - Refresh',
                          onPressed: Actions.handler<RefreshIntent>(context, RefreshIntent()),
                        ),
                      ),
                    ],
                  ),
                  body: Focus(
                    autofocus: true,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: Text(exceptionMessage(snapshot.error))),
                    ),
                  ),
                  drawer: const AppDrawer(),
                ),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(header),
                flexibleSpace: const AppProgressIndicator(),
                actions: const [
                  IconButton(icon: Icon(Icons.refresh), onPressed: null),
                ],
              ),
              body: const Center(child: Loading()),
              drawer: const AppDrawer(),
            );
          }
        });
  }
}
