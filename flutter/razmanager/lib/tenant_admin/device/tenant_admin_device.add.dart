import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:provider/provider.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/internal/io/commissioning.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/grpc_client.dart';
import '../../utilities/network_device.dart';

class TenantAdminDeviceAdd extends StatefulWidget {
  const TenantAdminDeviceAdd({super.key, this.refreshItems});

  final AsyncCallback? refreshItems;

  @override
  State<TenantAdminDeviceAdd> createState() => _TenantAdminDeviceAddState();
}

class _TenantAdminDeviceAddState extends State<TenantAdminDeviceAdd> with ExceptionMessage, GrpcClient, NetworkDeviceFinder {
  StreamSubscription<String>? _exceptionStreamSubscription;
  final ValueNotifier<List<NetworkDevice>> _networkDevicesValueNotifier = ValueNotifier([]);

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    _exceptionStreamSubscription = context.read<AppModel>().exceptionStreamController.stream.listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 10)));
    });

    refreshData(notify: false);
  }

  @override
  void dispose() async {
    super.dispose();
    if (_exceptionStreamSubscription != null) {
      await _exceptionStreamSubscription!.cancel();
    }
  }

  Future<void> refreshData({required bool notify}) async {
    final model = context.read<AppModel>();
    model.setBusy(value: true, notify: notify);
    _networkDevicesValueNotifier.value = [];

    await networkDevicesFind(networkDeviceFound);

    model.setBusy(value: false, notify: true);
  }

  Future<void> networkDeviceFound(NetworkDevice networkDevice) async {
    _networkDevicesValueNotifier.value.add(networkDevice);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices - Add'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<List<NetworkDevice>>(
          builder: (BuildContext context, List<NetworkDevice> value, _) {
            if (_networkDevicesValueNotifier.value.isEmpty) {
              return Text("No devices found.");
            } else {
              return ListView.separated(
                itemCount: _networkDevicesValueNotifier.value.length,
                itemBuilder: (context, index) {
                  final item = _networkDevicesValueNotifier.value.elementAt(index);
                  return ListTile(
                    title: Text(item.systemInformation.hardwareModel.hasValue() ? item.systemInformation.hardwareModel.value : "?"),
                    subtitle: Text(item.ipAddress),
                    onTap: () async {
                      if (!context.mounted) {
                        return;
                      }

                      final model = context.read<AppModel>();
                      model.setBusy(value: true, notify: true);

                      grpc.ClientChannel? commissioningClientChannel;
                      grpc.ClientChannel? backendClientChannel;

                      try {
                        commissioningClientChannel = grpc.ClientChannel(
                          item.ipAddress,
                          port: 3302,
                          options: grpc.ChannelOptions(credentials: grpc.ChannelCredentials.secure(onBadCertificate: (certificate, host) => true)),
                        );

                        final commissioningClient = CommissioningServiceClient(commissioningClientChannel);
                        final commissioningCertificateRequest = await commissioningClient.certificateRequest(Empty());

                        backendClientChannel = createClientChannel();
                        final backendClient = DeviceServiceClient(backendClientChannel, options: callOptionsFromContext(context));
                        final certificateResponse = await backendClient.certificateRequest(
                          DeviceCommissioningCertificateRequest(
                            certificateRequestPem: commissioningCertificateRequest.certificateRequestPem,
                            name: commissioningCertificateRequest.name,
                          ),
                        );
                        await commissioningClient.certificateResponse(CommissioningCertificateResponse(certificatePem: certificateResponse.certificatePem));
                      } catch (e) {
                        debugPrint('Something really unknown: $e');
                      } finally {
                        if (commissioningClientChannel != null) {
                          await commissioningClientChannel.shutdown();
                        }
                        if (backendClientChannel != null) {
                          await backendClientChannel.shutdown();
                        }
                        await widget.refreshItems!();
                        model.setBusy(value: false, notify: true);
                      }

                      if (!context.mounted) {
                        return;
                      }
                      context.pop();
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            }
          },
          valueListenable: _networkDevicesValueNotifier,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            FilledButton.tonalIcon(
              label: const Text('Add a simulated IO device'),
              onPressed: () {
                context.pop();
                context.push('/tenant-admin/devices/add/simulated', extra: widget.refreshItems);
              },
            ),
          ],
        ),
      ),
    );
  }
}
