import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';

import '../protobuf/razmanager/protobuf/internal/io/system_information.pbgrpc.dart';

class NetworkDevice {
  NetworkDevice({required this.ipAddress, required this.systemInformation});
  String ipAddress;
  SystemInformationRead systemInformation;
}

mixin NetworkDeviceFinder {
  Future<void> networkDevicesFind(Future<void> Function(NetworkDevice networkDevice) callback) async {
    try {
      final networkInterfaceList = await NetworkInterface.list(type: InternetAddressType.IPv4);
      var networkInterfaceSubnets = networkInterfaceList.map(
        (networkInterface) => networkInterface.addresses.map((internetAddress) => internetAddress.rawAddress.take(3)),
      );
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
          futures.add(_networkDeviceFind(address: address, callback: callback));
        }
      }
      await Future.wait(futures);
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }

  Future<void> _networkDeviceFind({required String address, required Future<void> Function(NetworkDevice networkDevice) callback}) async {
    debugPrint(address);

    grpc.ClientChannel? clientChannel;

    try {
      clientChannel = grpc.ClientChannel(
        address,
        port: 3302,
        options: grpc.ChannelOptions(credentials: grpc.ChannelCredentials.secure(onBadCertificate: (certificate, host) => true)),
      );

      final client = SystemInformationServiceClient(clientChannel);
      final systemInformation = await client.read(Empty());
      debugPrint(address);
      debugPrint(systemInformation.softwareOsVersion.value);

      await callback(NetworkDevice(ipAddress: address, systemInformation: systemInformation));
    } catch (exception) {
      //debugPrint(exception.toString());
    } finally {
      if (clientChannel != null) {
        clientChannel.shutdown();
      }
    }
  }
}
