import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../app_model.dart';
import '../app_progress_indicator.dart';
import 'exception_message.dart';
import 'grpc_client.dart';
import 'intent.dart';
import 'loading.dart';

abstract class CrudMasterAlertBase extends StatefulWidget {
  const CrudMasterAlertBase(
      {super.key,
      required this.parentId,
      required this.id});
  final String? parentId;
  final String? id;
}

abstract class CrudMasterAlertStateBase<TReadProto>
    extends State<CrudMasterAlertBase> with GrpcClient, ExceptionMessage {
  CrudMasterAlertStateBase({required this.header, required this.child});
  final String header;
  final Widget child;
  String? etag;
  late TReadProto readProto;
  late FormGroup formGroup;
  bool add = false;

  grpc.ClientChannel? clientChannel;
  StreamSubscription<String>? exceptionStreamSubscription;

  Future<TReadProto> initialize();
  Future read(String id);
  Future<void> save(String? id);
  Future<void> delete(String id);
  Future<void> createFormGroup(TReadProto readProto);
  void onSaved() {}
  void onDeleted() {}
  String? snackBarText;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    exceptionStreamSubscription = context
        .read<AppModel>()
        .exceptionStreamController
        .stream
        .listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message), duration: const Duration(seconds: 10)));
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
    try {
      model.setBusy(value: true, notify: false);
      clientChannel = createClientChannel();
      if (widget.id == 'add') {
        add = true;
        readProto = await initialize();
      } else {
        add = false;
        (TReadProto, String) readResult = await read(widget.id!);
        readProto = readResult.$1;
        etag = readResult.$2;
      }

      await createFormGroup(readProto);
    } finally {
      if (clientChannel != null) {
        await clientChannel!.shutdown();
      }
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
              final state =
                  context.findAncestorStateOfType<CrudMasterAlertStateBase>()!;
              return ReactiveForm(
                formGroup: formGroup,
                child: Actions(
                  actions: {
                    // if (this.shouldPop)
                    //   CloseIntent: CallbackAction<CloseIntent>(onInvoke: (intent) {
                    //     context.pop();
                    //     return;
                    //   }),
                    SaveIntent: SaveAction(),
                    DeleteIntent: DeleteAction(),
                  },
                  child: Focus(
                    autofocus: true,
                    child: AlertDialog(
                        title: Text(header),
                        content: IntrinsicHeight(
                            child: Column(
                          children: [
                            child,
                            if (snackBarText != null) Text(snackBarText!)
                          ],
                        )),
                        actions: [
                          ReactiveFormConsumer(
                              builder: (context, formGroup, child) {
                            return Tooltip(
                              message: 'Ctrl+S - Save',
                              child: FilledButton.icon(
                                icon: const Icon(Icons.save),
                                label: const Text('Save'),
                                onPressed: Actions.handler<SaveIntent>(
                                    context, SaveIntent()),
                              ),
                            );
                          }),
                          if (!state.add)
                            ReactiveFormConsumer(
                                builder: (context, formGroup, child) {
                              return Tooltip(
                                message: 'Ctrl+D - Delete',
                                child: FilledButton.tonalIcon(
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete'),
                                  onPressed: Actions.handler<DeleteIntent>(
                                      context, DeleteIntent()),
                                ),
                              );
                            })
                        ]),
                  ),
                ),
              );
            } else {
              return AlertDialog(
                title: Text(header),
                content: Text(exceptionMessage(snapshot.error)),
              );
            }
          } else {
              return Center(child: Loading());
          }
        });
  }
}

class SaveAction extends ContextAction<SaveIntent> with ExceptionMessage {
  @override
  void invoke(SaveIntent intent, [BuildContext? context]) async {
    if (context != null) {
      final model = context.read<AppModel>();
      final state = context.findAncestorStateOfType<CrudMasterAlertStateBase>();
      if (state != null) {
        model.setBusy(value: true, notify: true);
        state.clientChannel = state.createClientChannel();
        try {
          await state.save(state.widget.id);
          state.onSaved();
          if (!context.mounted) {
            return;
          }
          Navigator.of(context).pop(true);
        } on Exception catch (exception) {
          state.snackBarText = exceptionMessage(exception);
          debugPrint(state.snackBarText);
        } finally {
          if (state.clientChannel != null) {
            await state.clientChannel!.shutdown();
          }
          model.setBusy(value: false, notify: true);
        }
      }
    }
  }

  @override
  bool isEnabled(SaveIntent intent, [BuildContext? context]) {
    if (context != null) {
      final model = context.read<AppModel>();
      final state = context.findAncestorStateOfType<CrudMasterAlertStateBase>();
      if (state != null) {
        return state.formGroup.valid && state.formGroup.dirty && !model.busy;
      }
    }
    return false;
  }
}

class DeleteAction extends ContextAction<DeleteIntent> with ExceptionMessage {
  @override
  void invoke(DeleteIntent intent, [BuildContext? context]) async {
    if (context != null) {
      final model = context.read<AppModel>();
      final state = context.findAncestorStateOfType<CrudMasterAlertStateBase>();
      if (state != null) {
        final confirmDelete = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'Do you really want to delete this ${state.header.toLowerCase()}?'),
                actions: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });
        if (confirmDelete == true) {
          if (!context.mounted) {
            return;
          }
          model.setBusy(value: true, notify: true);
          state.clientChannel = state.createClientChannel();
          try {
            await state.delete(state.widget.id!);
            state.onDeleted();
            if (!context.mounted) {
              return;
            }
            Navigator.of(context).pop(true);
          } on Exception catch (exception) {
            state.snackBarText = exceptionMessage(exception);
          } finally {
            if (state.clientChannel != null) {
              await state.clientChannel!.shutdown();
            }
            model.setBusy(value: false, notify: true);
          }
        }
      }
    }
  }

  @override
  bool isEnabled(DeleteIntent intent, [BuildContext? context]) {
    if (context != null) {
      final model = context.read<AppModel>();
      return !model.busy;
    }
    return false;
  }
}
