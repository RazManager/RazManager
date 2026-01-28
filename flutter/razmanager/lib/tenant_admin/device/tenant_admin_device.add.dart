import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:provider/provider.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../../app_model.dart';
import '../../app_progress_indicator.dart';
import '../../protobuf/razmanager/protobuf/internal/io/commissioning.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/io/system_information.pbgrpc.dart';
import '../../protobuf/razmanager/protobuf/internal/repository/crud_services/device.pbgrpc.dart';
import '../../refresh_model.dart';
import '../../utilities/exception_message.dart';
import '../../utilities/grpc_client.dart';

class TenantAdminDeviceAdd extends StatefulWidget {
  const TenantAdminDeviceAdd({super.key, this.refreshItems});

  final AsyncCallback? refreshItems;

  @override
  State<TenantAdminDeviceAdd> createState() => _TenantAdminDeviceAddState();
}

class _TenantAdminDeviceAddState extends State<TenantAdminDeviceAdd>
    with ExceptionMessage, GrpcClient {
  StreamSubscription<String>? _exceptionStreamSubscription;
  final ValueNotifier<List<_NetworkDevice>> _networkDevicesValueNotifier =
      ValueNotifier([]);

  @override
  didChangeDependencies() {
    super.didChangeDependencies();

    _exceptionStreamSubscription = context
        .read<AppModel>()
        .exceptionStreamController
        .stream
        .listen((message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message), duration: const Duration(seconds: 10)));
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
    try {
      final networkInterfaceList =
          await NetworkInterface.list(type: InternetAddressType.IPv4);
      var networkInterfaceSubnets = networkInterfaceList.map(
          (networkInterface) => networkInterface.addresses
              .map((internetAddress) => internetAddress.rawAddress.take(3)));
      final List<Iterable<int>> subnets = [];
      for (var networkInterfaceSubnet in networkInterfaceSubnets) {
        for (var addressSubnet in networkInterfaceSubnet) {
          var found = false;
          for (var subnet in subnets) {
            if (listEquals(subnet.toList(), addressSubnet.toList())) {
              found = true;
              break;
            }
          }
          if (!found) {
            subnets.add(addressSubnet);
          }
        }
      }

      final futures = <Future>[];
      for (var subnet in subnets) {
        final subnetString = subnet.join(".");
        debugPrint(subnetString);
        for (var i = 0; i <= 255; i++) {
          final address = "$subnetString.$i";
          futures.add(findNetworkDevice(address));
        }
      }
      await Future.wait(futures);
      print (_networkDevicesValueNotifier.value.length);

      // var responses = await Future.wait(futures);
      // for (var response in responses) {
      //   final networkDevice = response as _NetworkDevice?;
      //   if (networkDevice != null) {
      //     _networkDevicesValueNotifier.value.add(networkDevice);
      //   }
      // }
    } catch (e) {
      // No specified type, handles all
      debugPrint('Something really unknown: $e');
    }

    model.setBusy(value: false, notify: true);
  }

  Future<void> findNetworkDevice(String address) async {
    debugPrint(address);

    grpc.ClientChannel? clientChannel;

    try {
      clientChannel = grpc.ClientChannel(
        address,
        port: 3302,
        options: grpc.ChannelOptions(
          credentials: grpc.ChannelCredentials.secure(
              onBadCertificate: (certificate, host) => true),
        ),
      );

      final client = SystemInformationServiceClient(clientChannel);
      final systemInformation = await client.read(Empty());
      debugPrint(address);
      debugPrint(systemInformation.softwareOsVersion.value);
      _networkDevicesValueNotifier.value.add(_NetworkDevice(
          ipAddress: address, systemInformation: systemInformation));
      setState(() {
        
      });
      // return _NetworkDevice(
      //     ipAddress: address, systemInformation: systemInformation);
    } catch (e) {
      // No specified type, handles all
      //debugPrint('Something really unknown: $e');
      //rethrow;
    } finally {
      if (clientChannel != null) {
        clientChannel.shutdown();
      }
    }
    //return null;
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
        child: ValueListenableBuilder<List<_NetworkDevice>>(
            builder: (BuildContext context, List<_NetworkDevice> value, _) {
              if (_networkDevicesValueNotifier.value.isEmpty) {
                return Text("No devices found.");
              } else {
                return ListView.separated(
                  itemCount: _networkDevicesValueNotifier.value.length,
                  itemBuilder: (context, index) {
                    final item =
                        _networkDevicesValueNotifier.value.elementAt(index);
                    return ListTile(
                        title: Text(
                            item.systemInformation.hardwareModel.hasValue()
                                ? item.systemInformation.hardwareModel.value
                                : "?"),
                        subtitle: Text(item.ipAddress),
                        onTap: () async {
                          //await appModel.tenantRefresh(item.id);
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
                                options: grpc.ChannelOptions(
                                    credentials: grpc.ChannelCredentials.secure(
                                        onBadCertificate: (certificate, host) =>
                                            true)));

                            final commissioningClient =
                                CommissioningServiceClient(
                                    commissioningClientChannel);
                            final commissioningCertificateRequest =
                                await commissioningClient
                                    .certificateRequest(Empty());

                            backendClientChannel = createClientChannel();
                            final backendClient = DeviceServiceClient(
                                backendClientChannel,
                                options: callOptionsFromContext(context));
                            final certificateResponse =
                                await backendClient.certificateRequest(
                                    DeviceCommissioningCertificateRequest(
                                        certificateRequestPem:
                                            commissioningCertificateRequest
                                                .certificateRequestPem,
                                        name: commissioningCertificateRequest
                                            .name));
                            await commissioningClient.certificateResponse(
                                CommissioningCertificateResponse(
                                    certificatePem:
                                        certificateResponse.certificatePem));
                          } catch (e) {
                            debugPrint('Something really unknown: $e');
                          } finally {
                            if (commissioningClientChannel != null) {
                              await commissioningClientChannel.shutdown();
                              if (backendClientChannel != null) {
                                await backendClientChannel.shutdown();
                              }

                              model.setBusy(value: false, notify: true);
                            }
                          }
                        });
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                );
              }
            },
            valueListenable: _networkDevicesValueNotifier),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            FilledButton.tonalIcon(
              label: const Text('Add a simulated IO device'),
              onPressed: () {
                context.pop();
                context.push('/tenant-admin/devices/io/add',
                    extra: widget.refreshItems);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NetworkDevice {
  _NetworkDevice({required this.ipAddress, required this.systemInformation});
  String ipAddress;
  SystemInformationRead systemInformation;
}
