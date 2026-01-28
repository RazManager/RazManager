import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_drawer.dart';
import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/public/version.v1.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/public/event_user_type_id.v1.pbenum.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/event.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/event_invite.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/tenant.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/user_services/tenant_invite.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/date_formatter.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/grpc_client.dart';
import '../../utilities/loading.dart';

enum InitializeDataPhase { initialize, versionNewer, token, data }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with GrpcClient, ExceptionMessage {
  StreamSubscription<String>? exceptionStreamSubscription;
  late VersionNewerResponse versionNewerResponse;
  int? confirmedVersionMajor;
  int? confirmedVersionMinor;
  int? confirmedVersionPatch;

  String title = 'RazManager';
  List<EventSelect> events = [];
  List<TenantSelect> tenants = [];
  InitializeDataPhase initializeDataPhase = InitializeDataPhase.initialize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    exceptionStreamSubscription = context.read<AppModel>().exceptionStreamController.stream.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 10)));
    });
  }

  @override
  void dispose() async {
    super.dispose();
    if (exceptionStreamSubscription != null) {
      await exceptionStreamSubscription!.cancel();
    }
  }

  Future<void> confirmVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final applicationVersion = packageInfo.version;
    final applicationVersionParts = applicationVersion.split('.');

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('confirmedVersionMajor', int.parse(applicationVersionParts[0]));
    sharedPreferences.setInt('confirmedVersionMinor', int.parse(applicationVersionParts[1]));
    sharedPreferences.setInt('confirmedVersionPatch', int.parse(applicationVersionParts[2]));
    setState(() {});
  }

  Future<void> initializeData() async {
    final appModel = context.read<AppModel>();

    grpc.ClientChannel? clientChannel;
    try {
      bool cont = true;
      clientChannel = createClientChannel();

      if (initializeDataPhase == InitializeDataPhase.initialize) {
        VersionPlatformId? versionPlatformId;
        if (Platform.isWindows) {
          versionPlatformId = VersionPlatformId.VERSION_PLATFORM_ID_WINDOWS;
        } else if (Platform.isLinux) {
          versionPlatformId = VersionPlatformId.VERSION_PLATFORM_ID_LINUX;
        } else if (Platform.isMacOS) {
          versionPlatformId = VersionPlatformId.VERSION_PLATFORM_ID_MACOS;
        } else if (Platform.isIOS) {
          versionPlatformId = VersionPlatformId.VERSION_PLATFORM_ID_IOS;
        } else if (Platform.isAndroid) {
          versionPlatformId = VersionPlatformId.VERSION_PLATFORM_ID_ANDROID;
        }

        final packageInfo = await PackageInfo.fromPlatform();
        final applicationVersion = packageInfo.version;
        debugPrint("applicationVersion: $applicationVersion");
        final applicationVersionParts = applicationVersion.split('.');
        debugPrint("applicationVersionParts.length: ${applicationVersionParts.length}");
        debugPrint("${applicationVersionParts[0]} ${applicationVersionParts[1]} ${applicationVersionParts[2]}");

        final sharedPreferences = await SharedPreferences.getInstance();
        final confirmedVersionMajor = sharedPreferences.getInt('confirmedVersionMajor');
        final confirmedVersionMinor = sharedPreferences.getInt('confirmedVersionMinor');
        final confirmedVersionPatch = sharedPreferences.getInt('confirmedVersionPatch');

        final versionNewerRequest = VersionNewerRequest(
          versionPlatformId: versionPlatformId,
          currentVersionMajor: int.parse(applicationVersionParts[0]),
          currentVersionMinor: int.parse(applicationVersionParts[1]),
          currentVersionPatch: int.parse(applicationVersionParts[2]),
          confirmedVersionMajor: int.parse(applicationVersionParts[0]),
          confirmedVersionMinor: int.parse(applicationVersionParts[1]),
          confirmedVersionPatch: int.parse(applicationVersionParts[2]),
        );

        if (confirmedVersionMajor != null && confirmedVersionMinor != null && confirmedVersionPatch != null) {
          versionNewerRequest.confirmedVersionMajor = confirmedVersionMajor;
          versionNewerRequest.confirmedVersionMinor = confirmedVersionMinor;
          versionNewerRequest.confirmedVersionPatch = confirmedVersionPatch;
        }

        versionNewerResponse = await VersionServiceClient(clientChannel).newer(versionNewerRequest);

        initializeDataPhase = InitializeDataPhase.versionNewer;
        cont = versionNewerResponse.result.isEmpty && versionNewerResponse.currentVersionValid;
      }

      if (cont && initializeDataPhase == InitializeDataPhase.versionNewer) {
        await appModel.tokenRefreshIfNeeded();
        initializeDataPhase = InitializeDataPhase.token;
      }

      if (cont && initializeDataPhase == InitializeDataPhase.token) {
        initializeDataPhase = InitializeDataPhase.data;
      }
    } finally {
      if (clientChannel != null) {
        await clientChannel.shutdown();
      }
    }

    return refreshData(notify: false);
  }

  Future<void> refreshData({required bool notify}) async {
    final model = context.read<AppModel>();
    grpc.ClientChannel? clientChannel;
    try {
      model.setBusy(value: true, notify: notify);
      clientChannel = createClientChannel();

      events = [];
      tenants = [];

      if (!mounted) {
        return;
      }

      final futures = <Future>[];
      futures.add(EventServiceClient(clientChannel, options: callOptionsFromContext(context)).select(Empty()));
      if (model.isAuthenticated()) {
        futures.add(TenantServiceClient(clientChannel, options: callOptionsFromContext(context)).select(Empty()));
      }
      var response = await Future.wait(futures);
      events = (response[0] as EventSelectResponse).result;
      if (response.length > 1) {
        tenants = (response[1] as TenantSelectResponse).result;
      }
    } finally {
      if (clientChannel != null) {
        await clientChannel.shutdown();
      }
      model.setBusy(value: false, notify: notify);
    }
  }

  Future<void> eventInvite() async {
    final result = await showDialog<(int?, EventUserTypeId?)>(
      context: context,
      builder: (context) {
        return ReactiveForm(
          formGroup: FormGroup({
            'code': FormControl<int>(validators: [Validators.required, Validators.min(100000)]),
            'eventUserTypeId': FormControl<EventUserTypeId?>(validators: [Validators.required]),
          }),
          child: AlertDialog(
            title: const Text('Join an event'),
            content: SizedBox(
              width: 300,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReactiveTextField<int>(
                    formControlName: 'code',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    decoration: const InputDecoration(labelText: 'Code *', helperText: 'Code you have recieved to join an event'),
                    validationMessages: {
                      ValidationMessage.required: (error) => 'Please enter a code.',
                      ValidationMessage.min: (error) => 'The code must be 6 characters long.',
                    },
                  ),
                  const SizedBox(height: 32),
                  Text('Join as a *', style: Theme.of(context).textTheme.bodyLarge),
                  ReactiveRadioListTile<EventUserTypeId?>(
                    formControlName: 'eventUserTypeId',
                    value: EventUserTypeId.EVENT_USER_TYPE_ID_DRIVER,
                    title: const Text('Driver'),
                  ),
                  ReactiveRadioListTile<EventUserTypeId?>(
                    formControlName: 'eventUserTypeId',
                    value: EventUserTypeId.EVENT_USER_TYPE_ID_VIEWER,
                    title: const Text('Viewer'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) => TextButton(
                  onPressed: formGroup.valid && formGroup.dirty
                      ? () {
                          Navigator.of(context).pop((formGroup.control('code').value, formGroup.control('eventUserTypeId').value));
                        }
                      : null,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (result != null) {
      if (!mounted) {
        return;
      }

      final model = context.read<AppModel>();
      grpc.ClientChannel? clientChannel;
      try {
        model.setBusy(value: true, notify: true);
        clientChannel = createClientChannel();
        await EventInviteServiceClient(
          clientChannel,
          options: callOptionsFromContext(context),
        ).create(EventInviteCreate(code: result.$1, eventUserTypeId: result.$2));
        final refreshModel = context.read<RefreshModel>();
        await refreshData(notify: true);
        refreshModel.refreshed();
      } on Exception catch (exception) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
      } finally {
        if (clientChannel != null) {
          await clientChannel.shutdown();
        }
        model.setBusy(value: false, notify: true);
      }
    }
  }

  Future<void> tenantInvite() async {
    final code = await showDialog<int?>(
      context: context,
      builder: (context) {
        return ReactiveForm(
          formGroup: FormGroup({
            'code': FormControl<int>(validators: [Validators.required, Validators.min(100000)]),
          }),
          child: AlertDialog(
            title: const Text('Join a club/place'),
            content: SizedBox(
              width: 300,
              child: ReactiveTextField<int>(
                formControlName: 'code',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
                decoration: const InputDecoration(labelText: 'Code *', helperText: 'Code you have recieved to join a club/place'),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Please enter a code.',
                  ValidationMessage.min: (error) => 'The code must be 6 characters long.',
                },
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              ReactiveFormConsumer(
                builder: (context, formGroup, child) => TextButton(
                  onPressed: formGroup.valid && formGroup.dirty
                      ? () {
                          Navigator.of(context).pop(formGroup.control('code').value);
                        }
                      : null,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (code != null) {
      if (!mounted) {
        return;
      }

      final model = context.read<AppModel>();
      grpc.ClientChannel? clientChannel;
      try {
        model.setBusy(value: true, notify: true);
        clientChannel = createClientChannel();
        await TenantInviteServiceClient(clientChannel, options: callOptionsFromContext(context)).create(TenantInviteCreate(code: code));
        final refreshModel = context.read<RefreshModel>();
        await refreshData(notify: true);
        refreshModel.refreshed();
      } on Exception catch (exception) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exceptionMessage(exception)), duration: const Duration(seconds: 10)));
      } finally {
        if (clientChannel != null) {
          await clientChannel.shutdown();
        }
        model.setBusy(value: false, notify: true);
      }
    }
  }

  Future<void> refreshCallback() async {
    final refreshModel = context.read<RefreshModel>();
    await refreshData(notify: true);
    refreshModel.refreshed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: initializeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasError) {
            if (initializeDataPhase == InitializeDataPhase.versionNewer) {
              return Scaffold(
                appBar: AppBar(title: Text(title)),
                body: _HomeVersionNewerBody(),
                drawer: const AppDrawer(),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(title),
                  flexibleSpace: const AppProgressIndicator(),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      tooltip: 'F5 - Refresh',
                      onPressed: () async {
                        final refreshModel = context.read<RefreshModel>();
                        await refreshData(notify: true);
                        refreshModel.refreshed();
                      },
                    ),
                  ],
                ),
                body: _HomeBody(),
                bottomNavigationBar: _HomeBottomNavigationBar(),
                drawer: const AppDrawer(),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(title: Text(title), flexibleSpace: const AppProgressIndicator()),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(exceptionMessage(snapshot.error)),
                      SizedBox(height: 16),
                      FilledButton.tonalIcon(icon: const Icon(Icons.refresh), label: const Text('Try again'), onPressed: () => context.push('/')),
                    ],
                  ),
                ),
              ),
              drawer: const AppDrawer(),
            );
          }
        } else {
          return Scaffold(
            appBar: AppBar(title: Text(title), flexibleSpace: const AppProgressIndicator()),
            body: const Center(child: Loading()),
            drawer: const AppDrawer(),
          );
        }
      },
    );
  }
}

class _HomeVersionNewerBody extends StatelessWidget with DateFormatter {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeState>()!;

    if (!state.versionNewerResponse.currentVersionValid) {
      Future.microtask(
        () =>
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You need to upgrade to a newer version."), duration: const Duration(days: 365))),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(state.versionNewerResponse.result.length <= 1 ? 'New version available:' : 'Newer versions available:'),
          SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: state.versionNewerResponse.result.length,
              itemBuilder: (context, index) {
                final item = state.versionNewerResponse.result.elementAt(index);
                return ListTile(
                  title: Row(
                    children: [
                      Text("${item.major}.${item.minor}.${item.patch}"),
                      SizedBox(width: 16),
                      Text(dateOnlyFormat(item.date.toDateTime())),
                      ...item.platforms
                          .map((x) {
                            return [SizedBox(width: 16), Text(x.name)];
                          })
                          .expand((i) => i),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.description.hasValue()) Text(item.description.value),
                      ...item.notes
                          .map((x) {
                            return [SizedBox(height: 8), Text(x.description)];
                          })
                          .expand((i) => i),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(padding: EdgeInsets.only(left: 16, right: 16), child: Divider());
              },
            ),
          ),
          if (state.versionNewerResponse.currentVersionValid) ...[
            SizedBox(height: 16),
            Center(
              child: FilledButton.tonalIcon(
                label: const Text('Continue'),
                onPressed: () {
                  state.confirmVersion();
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget with DateFormatter {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: false);
    final state = context.findAncestorStateOfType<_HomeState>()!;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/background.jpg')),
      ),
      child: Consumer<RefreshModel>(
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Opacity(
                    opacity: 0.95,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Events', style: Theme.of(context).textTheme.bodyLarge),
                            if (state.events.isEmpty) const Text("There currently are no events available which you can view."),
                            if (state.events.isNotEmpty) const Text('Select an event you want to view.'),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: state.events.length,
                                itemBuilder: (context, index) {
                                  final item = state.events.elementAt(index);
                                  return ListTile(
                                    leading: item.image.hasValue()
                                        ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.image.value)))
                                        : item.tenant.image.hasValue()
                                        ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.tenant.image.value)))
                                        : const Icon(Icons.event, size: 40),
                                    title: Text(item.name),
                                    subtitle: Text(item.tenant.name),
                                    trailing: item.startsAt.hasSeconds()
                                        ? Text(dateTimeFormat(item.startsAt.toDateTime(toLocal: true)), style: Theme.of(context).textTheme.bodyMedium)
                                        : null,
                                    onTap: () async {
                                      //await appModel.tenantRefresh(item.id);
                                      if (!context.mounted) {
                                        return;
                                      }
                                      context.go('/public/events/${item.id}');
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: !appModel.isAuthenticated() ? null : () => state.eventInvite(),
                              child: const Text('Enter an event invitation code'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Opacity(
                    opacity: 0.95,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clubs/Places', style: Theme.of(context).textTheme.bodyLarge),
                            if (state.tenants.isEmpty) const Text("Your're not an administrator of any clubs/places."),
                            if (state.tenants.isNotEmpty) const Text('Administer one of your clubs/places and its events.'),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: state.tenants.length,
                                itemBuilder: (context, index) {
                                  final item = state.tenants.elementAt(index);
                                  return ListTile(
                                    leading: item.image.hasValue()
                                        ? CircleAvatar(foregroundImage: MemoryImage(Uint8List.fromList(item.image.value)))
                                        : const Icon(Icons.place, size: 40),
                                    title: Text(item.name),
                                    onTap: () async {
                                      await appModel.tenantRefresh(item.id);
                                      if (!context.mounted) {
                                        return;
                                      }
                                      context.go('/tenant-admin/events');
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonalIcon(
                              icon: const Icon(Icons.add),
                              label: const Text('Create a new club/place'),
                              onPressed: null, // !appModel.isAuthenticated() ? null : () => context.go('/tenant-admin/tenant/add'),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: !appModel.isAuthenticated() ? null : () => state.tenantInvite(),
                              child: const Text('Enter a club/place invitation code'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HomeBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeState>()!;
    return BottomAppBar(
      child: Consumer<AppModel>(
        builder: (context, model, child) {
          return Row(
            children: [
              FilledButton.tonalIcon(
                icon: const Icon(Icons.person),
                label: const Text('Sign-in'),
                onPressed: model.isAuthenticated() ? null : () => context.push('/public/sign-in', extra: state.refreshCallback),
              ),
              const SizedBox(width: 16),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.person_add),
                label: const Text('Sign-up'),
                onPressed: model.isAuthenticated() ? null : () => context.push('/public/sign-up', extra: state.refreshCallback),
              ),
              const SizedBox(width: 16),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.person_off),
                label: const Text('Sign-out'),
                onPressed: !model.isAuthenticated()
                    ? null
                    : () async {
                        await model.tokenSignOut();
                        await state.refreshCallback();
                      },
              ),
            ],
          );
        },
      ),
    );
  }
}
